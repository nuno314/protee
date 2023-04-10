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
}

class ProteeEnv extends Env {
  static final Map<String, dynamic> env = {
    Env.environment: Env.prodEnvName,
    Env.developmentMode: kDebugMode,
    Env.appName: 'Protee Production',
    Env.baseApiLayer: '',
    Env.app: 'protee',
    Env.onesignalAppID: ''
  };
}
