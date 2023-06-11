part of 'join_family_requests_repository.dart';

class JoinFamilyRequestsRepositoryImpl extends JoinFamilyRequestsRepository {
  final _restApi = injector.get<AppApiService>().client;
  @override
  Future<List<JoinFamilyRequest>> getData() {
    return _restApi.getJoinFamilyRequests();
  }
}
