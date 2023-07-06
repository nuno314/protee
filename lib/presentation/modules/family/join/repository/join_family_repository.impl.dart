part of 'join_family_repository.dart';

class JoinFamilyRepositoryImpl extends JoinFamilyRepository {
  final _restApi = injector.get<AppApiService>().client;
  final _local = injector.get<AppApiService>().localDataManager;

  @override
  Future<bool> joinFamily(String code) {
    return _restApi
        .joinFamily(code: code)
        .then((value) => value?.result ?? false);
  }
}
