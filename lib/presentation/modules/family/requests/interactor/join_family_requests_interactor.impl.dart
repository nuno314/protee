part of 'join_family_requests_interactor.dart';

class JoinFamilyRequestsInteractorImpl extends JoinFamilyRequestsInteractor {
  final JoinFamilyRequestsRepository _repository;

  JoinFamilyRequestsInteractorImpl(this._repository);

  @override
  Future<List<JoinFamilyRequest>> getData() {
    return _repository.getData();
  }

}
