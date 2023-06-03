part of 'join_family_repository.dart';

class JoinFamilyRepositoryImpl extends JoinFamilyRepository {
  final _restApi = injector.get<AppApiService>().client;

  Future<bool> joinFamily(String code) {
    return _restApi.joinFamily(code: code).then((value) => value ?? false);
  }
}
