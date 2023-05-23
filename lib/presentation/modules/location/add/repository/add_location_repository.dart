import '../../../../../common/client_info.dart';
import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/place_prediction.dart';
import '../../../../../di/di.dart';

part 'add_location_repository.impl.dart';

abstract class AddLocationRepository {
  Future<List<PlacePrediction>> searchPlaces(String input);
}
