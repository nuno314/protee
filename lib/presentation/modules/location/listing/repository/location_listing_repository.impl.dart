part of 'location_listing_repository.dart';

class LocationListingRepositoryImpl extends LocationListingRepository {
  final _restApi = injector.get<AppApiService>().client;
  @override
  Future<List<Location>> getData(
    int offset,
    int limit,
  ) {
    return Future.value([]);
  }
}
