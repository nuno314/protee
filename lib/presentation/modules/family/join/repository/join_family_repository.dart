import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../di/di.dart';

part 'join_family_repository.impl.dart';

abstract class JoinFamilyRepository {
  Future<bool> joinFamily(String code);
}
