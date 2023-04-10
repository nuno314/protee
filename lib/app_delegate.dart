import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timeago/timeago.dart';

import 'common/config.dart';
import 'common/constants/locale/app_locale.dart';
import 'common/utils.dart';
import 'di/di.dart';
import 'presentation/modules/app.dart';

class AppDelegate {
  static Future<dynamic> run(Map<String, dynamic> env) async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    Config.instance.setup(env);
    await Hive.initFlutter();

    await Firebase.initializeApp();
    await configureDependencies();
    setLocaleMessages(AppLocale.vi.languageCode, ViMessages());
    setLocaleMessages(AppLocale.en.languageCode, EnMessages());

    return runZonedGuarded(() async {
      runApp(const App());
    }, (Object error, StackTrace stack) {
      LogUtils.e('Error from runZonedGuarded', error, stack);
    });
  }
}
