import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/user.dart';
import '../../../../../di/di.dart';

part 'message_detail_repository.impl.dart';

abstract class MessageDetailRepository {
  Future<List<User>> getMembers();
}