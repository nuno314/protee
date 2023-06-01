part of 'add_member_repository.dart';

class AddMemberRepositoryImpl extends AddMemberRepository {
  final _restApiClient = injector.get<AppApiService>().client;
  @override
  Future<String?> getInvitationCode() {
    return _restApiClient.getInviteCode();
  }
}
