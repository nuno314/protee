import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../data/data_source/local/local_data_manager.dart';
import '../../../data/data_source/remote/app_api_service.dart';
import '../../../data/models/user.dart' as user;
import '../../../di/di.dart';
import '../../utils.dart';
import '../auth_service.dart';

@Singleton(as: AuthService)
class AppAuthService implements AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _localDataManager = injector.get<LocalDataManager>();
  final _authRepo = injector.get<AppApiService>();

  @override
  bool get isSignedIn =>
      _firebaseAuth.currentUser != null &&
      _localDataManager.refreshToken.isNotNullOrEmpty;

  @override
  String? get token => _localDataManager.accessToken;

  @override
  String? get userId =>
      _firebaseAuth.currentUser?.email ?? _firebaseAuth.currentUser?.uid;

  @override
  Future<String?> refreshToken() async {
    final result =
        await _authRepo.client.refreshToken(_localDataManager.refreshToken!);

    _localDataManager.notifyUserChanged(result.user);

    await _localDataManager.setAccessToken(result.accessToken);

    await _localDataManager.setRefreshToken(result.refreshToken);

    return result.accessToken;
  }

  @override
  Future<bool> loginSocial(String token) async {
    final result = await _authRepo.client.registerByEmail(
      token: token,
    );

    _localDataManager.notifyUserChanged(result?.user);

    await _localDataManager.setAccessToken(result?.accessToken);

    await _localDataManager.setRefreshToken(result?.refreshToken);

    return true;
  }

  @override
  Future<void> init() async {
    if (isSignedIn == true) {
      await refreshToken();
    } else {
      await _localDataManager.clearData();
    }
  }

  @override
  Future<void> signOut() async {
    LogUtils.i('$runtimeType signOut');
    await _localDataManager.setAccessToken(null);
    await _localDataManager.setRefreshToken(null);
    return _firebaseAuth.signOut();
  }

  @override
  Future<bool> updateProfile(user.User user) async {
    final res = await _authRepo.client.updateProfile(
      name: user.name,
      phoneNumber: user.phoneNumber,
      dob: user.dob?.toIso8601String(),
      email: user.email,
      avatar: user.avatar,
    );

    _localDataManager.notifyUserChanged(res);

    return res != null;
  }
}
