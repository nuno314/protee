part of 'join_family_interactor.dart';

class JoinFamilyInteractorImpl extends JoinFamilyInteractor {
  final JoinFamilyRepository _repository;

  JoinFamilyInteractorImpl(this._repository);

  @override
  Future<bool> joinFamily(String code) {
    return _repository.joinFamily(code);
  }
}
