import 'package:flutter/foundation.dart';

class Env {
  static const environment = 'environment';
  static const developmentMode = 'developmentMode';
  static const appName = 'appname';
  static const baseApiLayer = 'baseApiLayer';
  static const app = 'platform';
  static const onesignalAppID = 'onesignalAppID';

  static const devEnvName = 'Development';
  static const prodEnvName = 'Production';

  static final Map<String, dynamic> devEnv = {
    Env.environment: Env.devEnvName,
    Env.developmentMode: kDebugMode,
    Env.appName: 'Protee Dev',
    Env.baseApiLayer: '',
    Env.onesignalAppID: '',
    Env.app: 'protee',
  };

  static final Map<String, dynamic> prodEnv = {
    Env.environment: Env.prodEnvName,
    Env.developmentMode: kDebugMode,
    Env.appName: 'Protee',
    Env.baseApiLayer: '',
    Env.onesignalAppID: '',
    Env.app: 'protee',
  };
}
