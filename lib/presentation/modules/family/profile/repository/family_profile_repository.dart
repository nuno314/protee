import '../../../../../common/utils.dart';
import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/family.dart';
import '../../../../../data/models/user.dart';
import '../../../../../di/di.dart';

part 'family_profile_repository.impl.dart';

abstract class FamilyProfileRepository {
  Future<Family?> getFamilyProfile();

  Future<List<UserFamily>> getFamilyMembers();

  Future<List<JoinFamilyRequest>> getRequests();

  Future<bool> removeMember(String id);

  Future<User?> leaveFamily();

  Future<UserFamily?> updateChild(String id);
  
  Future<UserFamily?> updateParent(String id);
}
