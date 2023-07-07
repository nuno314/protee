import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../di/di.dart';
import '../../../../data/models/notification_model.dart';

part 'notification_repository.impl.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> getData(
    int page,
    int take,
  );

  Future<NotificationModel?> readNoti(String id);

  Future<bool> readAllNoti();
}
