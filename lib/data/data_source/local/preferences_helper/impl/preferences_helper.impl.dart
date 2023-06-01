part of '../preferences_helper.dart';

@Injectable(as: PreferencesHelper)
class PreferencesHelperImpl extends PreferencesHelper {
  late final SharedPreferences _prefs = injector.get();

  @override
  SupportedTheme getTheme() {
    final theme = _prefs.getString(PreferencesKey.theme);
    if (theme == null || theme == SupportedTheme.light.name) {
      return SupportedTheme.light;
    }
    return SupportedTheme.dark;
  }

  @override
  Future<bool> setTheme(String? data) async {
    if (data == null) {
      return _prefs.remove(PreferencesKey.theme);
    }
    return _prefs.setString(PreferencesKey.theme, data);
  }

  @override
  String? getLocalization() {
    return _prefs.getString(PreferencesKey.localization);
  }

  @override
  Future<bool> saveLocalization(String? locale) async {
    if (locale == null) {
      return _prefs.remove(PreferencesKey.localization);
    }
    return _prefs.setString(PreferencesKey.localization, locale);
  }

  @override
  Future<bool> clearData() async {
    final theme = getTheme();
    final locale = getLocalization();

    await _prefs.clear();

    final result = await Future.wait([
      saveLocalization(locale),
      setTheme(theme.name),
    ]);

    return result.any((e) => e == false) == false;
  }

  @override
  Future<bool?> markLaunched() async {
    return _prefs.setString(PreferencesKey.isLaunched, 'yes');
  }

  @override
  Future<bool?> unMarkLaunched() {
    return _prefs.remove(PreferencesKey.isLaunched);
  }

  @override
  bool isFirstLaunch() {
    return _prefs.getString(PreferencesKey.isLaunched)?.isNullOrEmpty == true;
  }

  @override
  String? get accessToken {
    final token = _prefs.getString(PreferencesKey.accessToken);

    if (token.isNullOrEmpty) {
      return null;
    }

    return token;
  }

  @override
  String? get refreshToken {
    final token = _prefs.getString(PreferencesKey.refreshToken);

    if (token.isNullOrEmpty) {
      return null;
    }

    return token;
  }

  @override
  Future<bool?> setAccessToken(String? value) {
    LogUtils.i('setAccessToken', value);
    if (value == null) {
      return _prefs.remove(PreferencesKey.accessToken);
    }
    return _prefs.setString(
      PreferencesKey.accessToken,
      value,
    );
  }

  @override
  Future<bool?> setRefreshToken(String? value) {
    LogUtils.i('setRefreshToken', value);
    if (value == null) {
      return _prefs.remove(PreferencesKey.refreshToken);
    }
    return _prefs.setString(
      PreferencesKey.refreshToken,
      value,
    );
  }
}
