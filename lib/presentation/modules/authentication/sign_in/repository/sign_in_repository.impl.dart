part of 'sign_in_repository.dart';

class SignInRepositoryImpl extends SignInRepository {
  final _authService = injector.get<AuthService>();

  @override
  Future<bool> signInWithSocialNetwork(String token) {
    return _authService.loginSocial(token);
  }
}
