part of 'add_location_interactor.dart';

class AddLocationInteractorImpl extends AddLocationInteractor {
  final AddLocationRepository _repository;

  AddLocationInteractorImpl(this._repository);

  @override
  Future<List<PlacePrediction>> searchPlace(String input) {
    return _repository.searchPlaces(input);
  }

  @override
  Future<GoogleMapPlace> getLocationByPlaceId(String id) {
    return _repository.getPlaceLocation(id);
  }

  @override
  Future<GoogleMapPlace?> getNearbyLocation(Location location) {
    return _repository.getNearbyPlaceByLocation(location.encode);
  }

  @override
  Future<List<GoogleMapPlace>> findPlaceFromText(String input) {
    return _repository.findPlaceFromText(input);
  }

  @override
  Future<bool> addLocation(String name, String description, Location location) {
    return _repository.addLocation(
      name: name,
      description: description,
      lat: location.lat!,
      lng: location.lng!,
    );
  }
}
