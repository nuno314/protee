part of 'message_interactor.dart';

class MessageInteractorImpl extends MessageInteractor {
  final MessageRepository _repository;

  MessageInteractorImpl(this._repository);

  @override
  Future sendMessage(String message) {
    return _repository.sendMessage(message);
  }

   late final _listingUsecase = ListingUseCase<Message, dynamic>(
    (offset, limit, [param]) => _repository.getData(offset, limit),
  );

  @override
  Pagination get pagination => _listingUsecase.pagination;

  @override
  Future<List<Message>> getData() {
    return _listingUsecase.getData();
  }

  @override
  Future<List<Message>> loadMoreData() {
    return _listingUsecase.loadMoreData();
  }
}
