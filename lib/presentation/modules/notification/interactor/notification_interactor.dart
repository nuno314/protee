import '../../../../../domain/entities/pagination.entity.dart';
import '../../../../../domain/use_case/listing_use_case.dart';
import '../../../../data/models/notification_model.dart';
import '../repository/notification_repository.dart';

part 'notification_interactor.imp.dart';

abstract class NotificationInteractor {
  Pagination get pagination;

  Future<List<NotificationModel>> getData();

  Future<List<NotificationModel>> loadMoreData();

  Future<NotificationModel?> readNoti(String id);

  Future<bool> readAllNoti();
}
