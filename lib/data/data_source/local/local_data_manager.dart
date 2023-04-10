import '../../../di/di.dart';
import '../../../domain/entities/token.dart';
import '../../../presentation/theme/theme_data.dart';
import 'preferences_helper/preferences_helper.dart';

class LocalDataManager implements AppPreferenceData {
  late final PreferencesHelper _preferencesHelper = injector.get();
  // final Box<Province>? _administrativeHiveBox;

  LocalDataManager(
      // this._administrativeHiveBox,
      );

  static Future<LocalDataManager> init() async {
    return Future.value(LocalDataManager());
  }

  ////////////////////////////////////////////////////////
  ///             Preferences helper
  ///
  @override
  SupportedTheme getTheme() {
    return _preferencesHelper.getTheme();
  }

  @override
  Future<bool?> setTheme(String? data) {
    return _preferencesHelper.setTheme(data);
  }

  @override
  String? getLocalization() {
    return _preferencesHelper.getLocalization();
  }

  @override
  Future<bool?> saveLocalization(String? locale) {
    return _preferencesHelper.saveLocalization(locale);
  }

  @override
  Future<bool?> clearData() {
    return _preferencesHelper.clearData();
  }

    @override
  Future<bool?> markLaunched() {
    return _preferencesHelper.markLaunched();
  }

  @override
  Future<bool?> unMarkLaunched() {
    return _preferencesHelper.unMarkLaunched();
  }

  @override
  bool isFirstLaunch() {
    return _preferencesHelper.isFirstLaunch();
  }

  @override
  Future<bool?> setToken(Token? value) {
    return _preferencesHelper.setToken(value);
  }

  @override
  Token? get token => _preferencesHelper.token;
}
