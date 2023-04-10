import 'dart:io';

import 'implementation/firebase_upload_service.dart';

abstract class UploadService {
  static const userProfilePath = 'user-profile';
  static const recording = 'user-recording';
  static const userUpload = 'user-upload';

  Future<String?> uploadFile(
    File file, {
    String? fileName,
    String? mimeType,
    String uploadFolder = UploadService.userUpload,
    void Function(Stream<UploadTaskSnapshot>)? onUploadStream,
  });
}
