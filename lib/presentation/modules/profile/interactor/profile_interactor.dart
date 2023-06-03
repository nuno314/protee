import '../../../../data/models/user.dart';
import '../repository/profile_repository.dart';

part 'profile_interactor.impl.dart';

abstract class ProfileInteractor {
  Future<bool> updateProfile(User user);
}
