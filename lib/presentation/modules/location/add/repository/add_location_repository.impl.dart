part of 'add_location_repository.dart';

class AddLocationRepositoryImpl extends AddLocationRepository {
  final _locationRepo = injector.get<AppApiService>().locationRepository;
  final _restApi = injector.get<AppApiService>().client;

  @override
  Future<List<PlacePrediction>> searchPlaces(String input) {
    return _locationRepo
        .getAutoComplete(input: input)
        .then((value) => value.predictions ?? []);
  }

  @override
  Future<GoogleMapPlace> getPlaceLocation(String id) {
    return _locationRepo
        .getPlaceDetail(placeId: id)
        .then((value) => value.result!);
  }

  @override
  Future<GoogleMapPlace?> getNearbyPlaceByLocation(String location) {
    return _locationRepo.getPlaceNearBySearch(location: location).then(
          (value) => value.results.firstOrNull,
        );
  }

  @override
  Future<bool> addLocation({
    required String name,
    required String description,
    required double lat,
    required double lng,
  }) {
    return _restApi
        .addLocation(
          name: name,
          lat: lat,
          lng: lng,
          description: description,
        )
        .then((value) => value.id != null);
  }
}
