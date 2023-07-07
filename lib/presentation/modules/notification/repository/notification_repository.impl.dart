part of 'notification_repository.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final _restApi = injector.get<AppApiService>().client;

  @override
  Future<List<NotificationModel>> getData(int page, int take) {
    return _restApi
        .getNotification(page: page, take: take)
        .then((value) => value?.data ?? []);
  }

  @override
  Future<NotificationModel?> readNoti(String id) {
    return _restApi.readNotification(id);
  }

  @override
  Future<bool> readAllNoti() {
    return _restApi
        .readAllNotifications()
        .then((value) => value?.result ?? false);
  }
}
