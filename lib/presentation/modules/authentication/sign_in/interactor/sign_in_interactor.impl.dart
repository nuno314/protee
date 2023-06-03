part of 'sign_in_interactor.dart';

class SignInInteractorImpl extends SignInInteractor {
  final SignInRepository _repository;

  SignInInteractorImpl(this._repository);

  @override
  Future<bool> logInByGoogle(String token) {
    return _repository.signInWithSocialNetwork(token);
  }

  @override
  Future<bool> logInByFacebook(String token) {
    return _repository.signInWithSocialNetwork(token);
  }
}
