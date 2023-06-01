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
}
