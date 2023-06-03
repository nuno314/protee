import '../../../../../common/utils/extensions.dart';
import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/place_prediction.dart';
import '../../../../../data/models/response.dart';
import '../../../../../di/di.dart';

part 'add_location_repository.impl.dart';

abstract class AddLocationRepository {
  Future<List<PlacePrediction>> searchPlaces(String input);

  Future<GoogleMapPlace> getPlaceLocation(String id);

  Future<GoogleMapPlace?> getNearbyPlaceByLocation(String location);

  Future<bool> addLocation({
    required String name,
    required String description,
    required double lat,
    required double lng,
  });
}
