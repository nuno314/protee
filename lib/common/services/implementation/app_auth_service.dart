import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../data/data_source/local/preferences_helper/preferences_helper.dart';
import '../../../data/models/authentication.dart';
import '../../../di/di.dart';
import '../../../domain/entities/token.dart';
import '../../utils/log_utils.dart';
import '../auth_service.dart';

@Singleton(as: AuthService)
class AppAuthService implements AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _localDataManager = injector.get<AppPreferenceData>();

  @override
  bool get isSignedIn => _firebaseAuth.currentUser != null;

  @override
  String? get token => _localDataManager.token?.accessToken;

  @override
  String? get userId =>
      _firebaseAuth.currentUser?.email ?? _firebaseAuth.currentUser?.uid;

  @override
  Future<String?> refreshToken() async {
    final _token = Token(
      token: await _firebaseAuth.currentUser?.getIdToken(true),
      type: 'firebase',
    );

    await _localDataManager.setToken(_token);

    return _token.accessToken;
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
  Future<bool> loginFirebase(String token) async {
    if (_firebaseAuth.currentUser == null) {
      final firebaseUser = await _firebaseAuth.signInWithCustomToken(token);
      LogUtils.d('loginFirebase', firebaseUser.toString());
    }
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
  Future<void> signOut() {
    return Future.value();
  }
}
