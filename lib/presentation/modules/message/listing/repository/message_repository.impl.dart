part of 'message_repository.dart';

class MessageRepositoryImpl extends MessageRepository {
  final _restApi = injector.get<AppApiService>().client;
  @override
  Future sendMessage(String message) {
    return _restApi.sendMessage(message: message);
  }

  @override
  Future<List<Message>> getData(int page, int take) {
    return _restApi
        .getMessages(page: page, take: take)
        .then((value) => value?.data ?? []);
  }
}
