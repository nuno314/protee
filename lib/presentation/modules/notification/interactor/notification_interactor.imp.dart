part of 'notification_interactor.dart';

class NotificationInteractorImpl extends NotificationInteractor {
  final NotificationRepository _repository;

  NotificationInteractorImpl(this._repository);

  late final _listingUsecase = ListingUseCase<NotificationModel, dynamic>(
    (offset, limit, [param]) => _repository.getData(offset, limit),
  );

  @override
  Pagination get pagination => _listingUsecase.pagination;

  @override
  Future<List<NotificationModel>> getData() {
    return _listingUsecase.getData();
  }

  @override
  Future<List<NotificationModel>> loadMoreData() {
    return _listingUsecase.loadMoreData();
  }

  @override
  Future<NotificationModel?> readNoti(String id) {
    return _repository.readNoti(id);
  }

  @override
  Future<bool> readAllNoti() {
    return _repository.readAllNoti();
  }
}
