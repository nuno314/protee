part of 'message_detail_repository.dart';

class MessageDetailRepositoryImpl extends MessageDetailRepository {
  final _restApi = injector.get<AppApiService>().client;
  @override
  Future<List<User>> getMembers() {
    return _restApi.getFamilyMembers().then((value) =>
        value
            ?.where((element) => element.user != null)
            .map((e) => e.user!)
            .toList() ??
        [],);
  }
}
