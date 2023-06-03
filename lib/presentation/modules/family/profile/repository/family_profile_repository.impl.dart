part of 'family_profile_repository.dart';

class FamilyProfileRepositoryImpl extends FamilyProfileRepository {
  final _restApi = injector.get<AppApiService>().client;

  @override
  Future<Family?> getFamilyProfile() {
    return _restApi.getFamilyProfile();
  }

  @override
  Future<List<User>> getFamilyMembers() {
    return _restApi.getFamilyMembers().then((value) => value ?? []);
  }

  @override
  Future<List<JoinFamilyRequest>> getRequests() {
    return _restApi.getJoinFamilyRequests();
  }

  @override
  Future<bool> removeMember(User member) {
    // return _restApi.removeMember();
    return Future.value(true);
  }
}
