import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import '../../../di/di.dart';
import '../../utils.dart';
import '../auth_service.dart';
import '../upload_service.dart';

class UploadTaskSnapshot {
  final int bytesTransferred;
  final int totalBytes;
  final String? url;
  final String filePath;

  UploadTaskSnapshot({
    required this.bytesTransferred,
    required this.totalBytes,
    required this.filePath,
    this.url,
  });

  double get percent => bytesTransferred.toDouble() / totalBytes;

  @override
  String toString() {
    return '''UploadTaskSnapshot(bytesTransferred: $bytesTransferred, totalBytes: $totalBytes, url: $url, filePath: $filePath)''';
  }
}

@Injectable(as: UploadService)
class FirebaseUploadService extends UploadService {
  @override
  Future<String?> uploadFile(
    File file, {
    String? fileName,
    String? mimeType,
    String uploadFolder = UploadService.userUpload,
    void Function(Stream<UploadTaskSnapshot>)? onUploadStream,
  }) async {
    final customFileName = fileName.isNotNullOrEmpty
        ? '$fileName.${basename(file.path).split('.').last}'
        : basename(file.path);

    // Create a Reference to the file
    final ref = FirebaseStorage.instance.ref(
      'mobile/${injector.get<AuthService>().userId}/$uploadFolder/$customFileName',
    );

    final streamCtrl = StreamController<UploadTaskSnapshot>.broadcast();

    final metadata = SettableMetadata(
      contentType: mimeType ?? lookupMimeType(file.path),
      customMetadata: {
        'picked-file-path': file.path,
      },
    );

    final task = ref.putFile(file, metadata);
    onUploadStream?.call(streamCtrl.stream);
    final _sub = task.snapshotEvents.listen(
      (e) {
        final uploadTaskSnapshot = UploadTaskSnapshot(
          bytesTransferred: e.bytesTransferred,
          totalBytes: e.totalBytes,
          filePath: file.path,
        );
        LogUtils.d(uploadTaskSnapshot);
        streamCtrl.add(uploadTaskSnapshot);
      },
      onError: (error, stackTrace) {
        LogUtils.e('uploadFile: ${file.path}', error, stackTrace);
        streamCtrl.addError(error, stackTrace);
      },
    );
    final snapshot = await task;
    await _sub.cancel();
    if (snapshot.state != TaskState.success) {
      streamCtrl.addError(Exception('Upload file failure!'));
      await streamCtrl.close();
      return null;
    }
    final url = await snapshot.ref.getDownloadURL();
    LogUtils.d('uploadFile: ${file.path}', url);
    streamCtrl.add(
      UploadTaskSnapshot(
        bytesTransferred: snapshot.bytesTransferred,
        totalBytes: snapshot.totalBytes,
        filePath: file.path,
        url: url,
      ),
    );
    await streamCtrl.close();
    return url;
  }
}
