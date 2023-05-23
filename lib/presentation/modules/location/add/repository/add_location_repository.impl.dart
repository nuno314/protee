part of 'add_location_repository.dart';

class AddLocationRepositoryImpl extends AddLocationRepository {
  final _locationRepo = injector.get<AppApiService>().locationRepository;

  @override
  Future<List<PlacePrediction>> searchPlaces(String input) {
    return _locationRepo
        .getAutoComplete(input: input)
        .then((value) => value.predictions ?? []);
  }
}
