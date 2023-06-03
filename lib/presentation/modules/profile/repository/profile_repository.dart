import '../../../../common/services/auth_service.dart';
import '../../../../data/models/user.dart';
import '../../../../di/di.dart';

part 'profile_repository.impl.dart';

abstract class ProfileRepository {
  Future<bool> updateProfile(User user);
}
