part of 'profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final _authService = injector.get<AuthService>();

  @override
  Future<bool> updateProfile(User user) {
    return _authService.updateProfile(user);
  }
}
