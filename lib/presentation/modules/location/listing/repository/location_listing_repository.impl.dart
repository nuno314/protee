part of 'location_listing_repository.dart';

class LocationListingRepositoryImpl extends LocationListingRepository {
  final _restApi = injector.get<AppApiService>().client;
  @override
  Future<List<UserLocation>> getData(
    int offset,
    int limit,
  ) {
    return _restApi.getLocation();
  }
}
