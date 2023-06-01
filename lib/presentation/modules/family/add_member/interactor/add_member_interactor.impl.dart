part of 'add_member_interactor.dart';

class AddMemberInteractorImpl extends AddMemberInteractor {
  final AddMemberRepository _repository;

  AddMemberInteractorImpl(this._repository);

  @override
  Future<String?> getInvitationCode() {
    return _repository.getInvitationCode();
  }
}
