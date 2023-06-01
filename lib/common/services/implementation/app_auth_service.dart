import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../data/data_source/local/local_data_manager.dart';
import '../../../data/data_source/remote/app_api_service.dart';
import '../../../data/models/authentication.dart';
import '../../../di/di.dart';
import '../../utils/log_utils.dart';
import '../auth_service.dart';

@Singleton(as: AuthService)
class AppAuthService implements AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _localDataManager = injector.get<LocalDataManager>();
  final _authRepo = injector.get<AppApiService>();

  @override
  bool get isSignedIn => _firebaseAuth.currentUser != null;

  @override
  String? get token => _localDataManager.accessToken;

  @override
  String? get userId =>
      _firebaseAuth.currentUser?.email ?? _firebaseAuth.currentUser?.uid;

  @override
  Future<String?> refreshToken() async {
    // final res =
    //     await _authRepo.client.refreshToken(_localDataManager.refreshToken!);

    // final _token = _authRepo.client.refreshToken(
    //   token: await _firebaseAuth.currentUser?.getIdToken(true),
    //   type: 'firebase',
    // );

    // //  _localDataManager.notifyUserChanged(result?.user);

    // _localDataManager.setAccessToken(_token.accessToken);

    // _localDataManager.setRefreshToken(_token.refreshToken);

    // return _token.accessToken;
    return '';
  }

  @override
  Future<LoginResult?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    LogUtils.d({'email': email, 'password': password});
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return LoginResult(
      accessToken: await refreshToken(),
      tokenType: 'firebase',
    );
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
    return _firebaseAuth.signOut();
  }
}
