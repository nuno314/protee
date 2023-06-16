import '../../../../../data/models/user.dart';
import '../repository/message_detail_repository.dart';

part 'message_detail_interactor.impl.dart';

abstract class MessageDetailInteractor {
  Future<List<User>> getMembers();
}
