part of 'family_profile_interactor.dart';

class FamilyProfileInteractorImpl extends FamilyProfileInteractor {
  final FamilyProfileRepository _repository;

  FamilyProfileInteractorImpl(this._repository);

  @override
  Future<Family?> getFamilyProfile() {
    return _repository.getFamilyProfile();
  }

  @override
  Future<List<User>> getFamilyMembers() {
    return _repository.getFamilyMembers();
  }

  @override
  Future<List<JoinFamilyRequest>> getRequests() {
    return _repository.getRequests();
  }

  @override
  Future<bool> removeMember(User member) {
    return _repository.removeMember(member);
  }
}
