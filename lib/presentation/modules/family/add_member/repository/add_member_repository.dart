import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../di/di.dart';

part 'add_member_repository.impl.dart';

abstract class AddMemberRepository {
  Future<String?> getInvitationCode();
}
