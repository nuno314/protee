abstract class AuthService {
  Future<void> init();

  bool get isSignedIn;

  String? get userId;

  String? get token;


  Future<String?> refreshToken();

  Future<void> signOut();

  // Future<LoginResult?> signInWithEmailAndPassword(
  //   String email,
  //   String password,
  // );

  Future<bool> loginFirebase(String token);
}
