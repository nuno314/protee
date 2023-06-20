part of 'family_profile_repository.dart';

class FamilyProfileRepositoryImpl extends FamilyProfileRepository {
  final _restApi = injector.get<AppApiService>().client;

  @override
  Future<Family?> getFamilyProfile() {
    return _restApi.getFamilyProfile();
  }

  @override
  Future<List<UserFamily>> getFamilyMembers() {
    return _restApi.getFamilyMembers().then((value) => value ?? []);
  }

  @override
  Future<List<JoinFamilyRequest>> getRequests() {
    return _restApi.getJoinFamilyRequests();
  }

  @override
  Future<bool> removeMember(String id) {
    return _restApi
        .removeMember(id: id)
        .then((value) => value?.result ?? false);
  }

  @override
  Future<bool> leaveFamily() {
    return _restApi.leaveFamily().then((value) => value?.result ?? false);
  }

  // @override
  // Future<User?> updateToParent() {
  //   return _restApi.updateToParent();
  // }
}
