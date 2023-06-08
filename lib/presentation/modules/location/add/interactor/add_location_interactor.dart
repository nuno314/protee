import '../../../../../data/models/location.dart';
import '../../../../../data/models/place_prediction.dart';
import '../../../../../data/models/response.dart';
import '../repository/add_location_repository.dart';

part 'add_location_interactor.impl.dart';

abstract class AddLocationInteractor {
  Future<List<PlacePrediction>> searchPlace(String input);

  Future<GoogleMapPlace> getLocationByPlaceId(String id);

  Future<GoogleMapPlace?> getNearbyLocation(Location location);

  Future<List<GoogleMapPlace>> findPlaceFromText(String input);

  Future<bool> addLocation(String name, String description, Location location);
}
