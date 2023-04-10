import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/utils.dart';
import '../../../../di/di.dart';
import '../../../../domain/entities/token.dart';
import '../../../../presentation/theme/theme_data.dart';
import 'preferences_key.dart';

part 'impl/preferences_helper.impl.dart';

abstract class PreferencesHelper extends AppPreferenceData {}

abstract class AppPreferenceData {
  SupportedTheme getTheme();

  Future<bool?> setTheme(String? data);

  String? getLocalization();

  Future<bool?> saveLocalization(String? locale);

  Future<bool?> clearData();

  Future<bool?> markLaunched();

  Future<bool?> unMarkLaunched();

  bool isFirstLaunch();

    /// Token
  Token? get token;

  Future<bool?> setToken(Token? value);
}
