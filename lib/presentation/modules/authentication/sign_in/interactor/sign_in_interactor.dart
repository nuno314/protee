import '../repository/sign_in_repository.dart';

part 'sign_in_interactor.impl.dart';

abstract class SignInInteractor {
  Future<bool> logInByGoogle(String token);

}