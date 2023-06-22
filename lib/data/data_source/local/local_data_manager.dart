import 'dart:async';

import '../../../common/utils/log_utils.dart';
import '../../../di/di.dart';
import '../../../presentation/theme/theme_data.dart';
import '../../models/user.dart';
import 'preferences_helper/preferences_helper.dart';

class SocketArgs {
  final String? accessToken;
  final String? familyId;

  SocketArgs({
    this.accessToken,
    this.familyId,
  });
}

class LocalDataManager extends AppPreferenceData {
  late final PreferencesHelper _preferencesHelper = injector.get();

  LocalDataManager();

  static Future<LocalDataManager> init() async {
    return Future.value(LocalDataManager());
  }

  final _userChangedController = StreamController<User?>.broadcast();
  User? _currentUser;

  Stream<User?> get onUserChanged {
    return _userChangedController.stream;
  }

  User? get currentUser {
    return _currentUser;
  }

  final _authChangedController = StreamController<SocketArgs>.broadcast();

  Stream<SocketArgs> get onAuthChanged => _authChangedController.stream;

  void notifyUserChanged(User? user, {String? accessToken}) {
    _authChangedController.add(
      SocketArgs(
        accessToken: accessToken ?? this.accessToken,
        familyId: user?.familyId ?? _currentUser?.familyId,
      ),
    );

    LogUtils.d('_notifyUserChanged: ${user?.name}');
    _userChangedController.add(user);
    _currentUser = user;
  }

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
  Future<bool?> clearData() async {
    await _authChangedController.close();

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
  String? get accessToken => _preferencesHelper.accessToken;

  @override
  String? get refreshToken => _preferencesHelper.refreshToken;

  @override
  Future<bool?> setAccessToken(String? value) {
    return _preferencesHelper.setAccessToken(value);
  }

  @override
  Future<bool?> setRefreshToken(String? value) {
    return _preferencesHelper.setRefreshToken(value);
  }
}
