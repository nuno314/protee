import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../common/utils.dart';
import '../../presentation/extentions/extention.dart';
import '../../presentation/modules/image_cropper/image_cropper_screen.dart';
import '../components/pick_file_helper/pick_file_helper.dart';
import '../services/permission_service.dart';

class ImagePicker {
  final BuildContext context;
  final String title;
  final bool crop;

  ImagePicker(this.context, this.title, {this.crop = false});

  Future<File?> show() {
    final completer = Completer<File?>();
    final trans = translate(context);
    showActionDialog(
      context,
      title: title,
      titleBottomBtn: trans.cancel,
      actions: {
        trans.takePhoto: () async {
          final file = await _openCamera();
          completer.complete(file);
        },
        trans.selectPhoto: () async {
          final file = await _openGallery();
          completer.complete(file);
        },
      },
    );
    return completer.future;
  }

  Future<File?> _openCamera() async {
    if (await PermissionService()
        .requestPermission(Permission.camera, context)) {
      final pickedFile = await PickFileHelper.takePicture();
      return _openImageCropper(pickedFile);
    }
    return null;
  }

  Future<File?> _openGallery() async {
    final checks = await PermissionService().requestPermissions(
      [Permission.photos, Permission.storage],
      context,
    );
    if (!checks.any((e) => !e)) {
      final trans = translate(context);
      final pickedFile = await PickFileHelper.pickFiles(
        dialogTitle: trans.avatar,
        type: FileType.image,
        allowMultiple: false,
      );
      return _openImageCropper(pickedFile.firstOrNull);
    }
    return null;
  }

  Future<File?> _openImageCropper(
    FilePicked? pickedFile,
  ) async {
    if (pickedFile == null || pickedFile.path?.isNotEmpty != true) {
      return null;
    }
    final imageFile = File(pickedFile.path!);
    if (!crop) {
      return imageFile;
    }
    final file = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) {
          return ImageCropperScreen(
            imagefile: imageFile,
          );
        },
      ),
    );
    return file as File?;
  }
}
