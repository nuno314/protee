import '../../../../../data/models/family.dart';
import '../repository/join_family_requests_repository.dart';

part 'join_family_requests_interactor.impl.dart';

abstract class JoinFamilyRequestsInteractor {
  Future<List<JoinFamilyRequest>> getData();

  Future<bool> approveRequest(String id);
}
