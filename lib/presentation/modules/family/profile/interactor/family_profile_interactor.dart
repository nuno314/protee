import '../../../../../data/models/family.dart';
import '../../../../../data/models/user.dart';
import '../repository/family_profile_repository.dart';

part 'family_profile_interactor.impl.dart';

abstract class FamilyProfileInteractor {
  Future<Family?> getFamilyProfile();

  Future<List<User>> getFamilyMembers();

  Future<List<JoinFamilyRequest>> getRequests();

  Future<bool> removeMember(User member);
}
