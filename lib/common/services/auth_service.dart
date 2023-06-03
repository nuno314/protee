import '../../data/models/user.dart';

abstract class AuthService {
  Future<void> init();

  bool get isSignedIn;

  String? get userId;

  String? get token;

  Future<String?> refreshToken();

  Future<void> signOut();

  Future<bool> loginSocial(String token);

  Future<bool> updateProfile(User user);
}
