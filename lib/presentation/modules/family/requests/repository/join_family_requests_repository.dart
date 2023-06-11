import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/family.dart';
import '../../../../../di/di.dart';

part 'join_family_requests_repository.impl.dart';

abstract class JoinFamilyRequestsRepository {
  Future<List<JoinFamilyRequest>> getData();
}
