import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../presentation/extentions/extention.dart';

export 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> _requestPermission(
    Permission ps,
    BuildContext context,
  ) async {
    var status = await ps.status;

    if (status.isDenied) {
      status = await ps.request();
    }

    if ((Platform.isAndroid && status.isPermanentlyDenied) ||
        (Platform.isIOS && (status.isDenied || status.isPermanentlyDenied))) {
      unawaited(_showPermissionWarningDialog(context));
      return false;
    }

    return !status.isDenied && !status.isPermanentlyDenied;
  }

  //////////////////////////////////////////////////////////////////
  ///                         Publish api                        ///
  //////////////////////////////////////////////////////////////////

  Future<bool> checkPermission(
    Permission ps,
    BuildContext context,
  ) async {
    final status = await ps.status;
    return !status.isDenied && !status.isPermanentlyDenied;
  }

  Future<bool> requestPermission(
    Permission ps,
    BuildContext context,
  ) async {
    var isGranted = await checkPermission(ps, context);
    if (!isGranted) {
      isGranted = await _requestPermission(ps, context);
    }
    return isGranted;
  }

  Future<List<bool>> requestPermissions(
    List<Permission> pss,
    BuildContext context,
  ) async {
    final result = <bool>[];
    for (final ps in pss) {
      result.add(await requestPermission(ps, context));
    }
    return result;
  }

  static Future<void> _showPermissionWarningDialog(BuildContext context) {
    final trans = translate(context);
    return showActionDialog(
      context,
      title: trans.haveNoPermission,
      titleBottomBtn: trans.cancel,
      actions: {
        trans.openSettings: openAppSettings,
      },
    );
  }
}
