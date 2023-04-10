import 'dart:async';

import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:injectable/injectable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../data/models/notification_model.dart';
import '../utils.dart';

@Singleton()
class OneSignalNotificationService {
  OneSignalNotificationService._();

  final _inAppNotificationController =
      StreamController<NotificationModel>.broadcast();

  Stream<NotificationModel> get onReceivedNotification =>
      _inAppNotificationController.stream;

  @factoryMethod
  static Future<OneSignalNotificationService> create() async {
    final instance = OneSignalNotificationService._();
    await instance._init();
    return instance;
  }

  Future<void> _init() async {
    if (kDebugMode) {
      await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    }
    // await OneSignal.shared.setAppId(Config.instance.appConfig.onesignalAppID);

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      _inAppNotificationController.add(
        NotificationModel.fromJson(event.notification.additionalData ?? {}),
      );
      LogUtils.d(
        'Onesignal ShowInForeground ${event.notification.additionalData}',
      );

      event.complete(event.notification);
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
      if (changes.to.status != OSNotificationPermission.authorized) {
        OneSignal.shared.promptUserForPushNotificationPermission(
          fallbackToSettings: true,
        );
      }
    });

    await OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});
  }

  Future<void> setUserId(String userId) async {
    if (kIsWeb) {
      return;
    }
    await OneSignal.shared.setExternalUserId(userId);
  }

  Future<void> setLanguage(String languageCode) async {
    if (kIsWeb) {
      return;
    }
    await OneSignal.shared.setLanguage(languageCode);
  }

  Future<void> removeUserId() async {
    if (kIsWeb) {
      return;
    }
    await OneSignal.shared.removeExternalUserId();
  }

  Future<Map<String, dynamic>> setTags(Map<String, dynamic> tags) {
    return OneSignal.shared.sendTags(tags);
  }

  Future<Map<String, dynamic>> deleteTags(List<String> keys) {
    return OneSignal.shared.deleteTags(keys);
  }

  void onNotificationOpened(
    void Function(OSNotificationOpenedResult) callback,
  ) {
    OneSignal.shared.setNotificationOpenedHandler(callback);
  }
}
