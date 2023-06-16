import '../../../../../data/models/message.dart';
import '../../../../../domain/entities/pagination.entity.dart';
import '../../../../../domain/use_case/listing_use_case.dart';
import '../repository/message_repository.dart';

part 'message_interactor.impl.dart';

abstract class MessageInteractor {
  Future<dynamic> sendMessage(String message);

  Pagination get pagination;

  Future<List<Message>> getData();

  Future<List<Message>> loadMoreData();
}
