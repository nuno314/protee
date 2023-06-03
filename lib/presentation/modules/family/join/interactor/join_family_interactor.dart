import '../repository/join_family_repository.dart';

part 'join_family_interactor.impl.dart';

abstract class JoinFamilyInteractor {
  Future<bool> joinFamily(String code);
}
