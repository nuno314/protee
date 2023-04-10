import '../envs.dart';

class Config {
  static final Config instance = Config._();

  Config._();

  AppConfig get appConfig => _appConfig;
  late AppConfig _appConfig;

  void setup(Map<String, dynamic> env) {
    _appConfig = AppConfig.from(env);
  }
}

class AppConfig {
  String envName;
  bool developmentMode;
  String appName;
  String baseApiLayer;
  String? onesignalAppID;
  String app;

  AppConfig(
    this.envName,
    this.developmentMode,
    this.appName,
    this.baseApiLayer,
    this.onesignalAppID,
    this.app,
  );

  AppConfig.from(Map<String, dynamic> env)
      : envName = env[Env.environment],
        developmentMode = env[Env.developmentMode],
        appName = env[Env.appName],
        baseApiLayer = env[Env.baseApiLayer],
        onesignalAppID = env[Env.onesignalAppID],
        app = env[Env.app];

  bool get isDevBuild => envName == Env.devEnvName;

  bool get isProdBuild => envName == Env.prodEnvName;
}
