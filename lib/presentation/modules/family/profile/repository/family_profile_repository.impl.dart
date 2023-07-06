part of 'family_profile_repository.dart';

class FamilyProfileRepositoryImpl extends FamilyProfileRepository {
  final _restApi = injector.get<AppApiService>().client;
  final _local = injector.get<AppApiService>().localDataManager;

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
  Future<User?> leaveFamily() async {
    final user = await _restApi.leaveFamily();
    _local.notifyUserChanged(user);
    return user;
  }

  @override
  Future<UserFamily?> updateChild(String id) {
    return _restApi.updateChild(id: id);
  }

  @override
  Future<UserFamily?> updateParent(String id) {
    return _restApi.updateParent(id: id);
  }

  // @override
  // Future<User?> updateToParent() {
  //   return _restApi.updateToParent();
  // }
}
