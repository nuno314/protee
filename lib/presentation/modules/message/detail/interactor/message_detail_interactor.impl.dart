part of 'message_detail_interactor.dart';

class MessageDetailInteractorImpl extends MessageDetailInteractor {
  final MessageDetailRepository _repository;

  MessageDetailInteractorImpl(this._repository);

  @override
   Future<List<User>> getMembers(){
    return _repository.getMembers();
  }
}
