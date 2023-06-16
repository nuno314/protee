import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/message.dart';
import '../../../../../di/di.dart';

part 'message_repository.impl.dart';

abstract class MessageRepository {
  Future<dynamic> sendMessage(String message);

  Future<List<Message>> getData(
     int page,
     int take,
  );
}
