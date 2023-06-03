part of 'profile_interactor.dart';

class ProfileInteractorImpl extends ProfileInteractor {
  final ProfileRepository _repository;

  ProfileInteractorImpl(this._repository);

  @override
  Future<bool> updateProfile(User user) {
    return _repository.updateProfile(user);
  }
}
