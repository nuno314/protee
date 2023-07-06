import '../../../../../data/models/family.dart';
import '../../../../../data/models/user.dart';
import '../repository/family_profile_repository.dart';

part 'family_profile_interactor.impl.dart';

abstract class FamilyProfileInteractor {
  Future<Family?> getFamilyProfile();

  Future<List<UserFamily>> getFamilyMembers();

  Future<List<JoinFamilyRequest>> getRequests();

  Future<bool> removeMember(String id);

  Future<User?> leaveFamily();

  Future<UserFamily?> updateChild(String id);

  Future<UserFamily?> updateParent(String id);
}
