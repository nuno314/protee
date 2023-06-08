import '../../../../../common/services/auth_service.dart';
import '../../../../../di/di.dart';

part 'sign_in_repository.impl.dart';

abstract class SignInRepository {
  Future<bool> signInWithSocialNetwork(String token);
}
