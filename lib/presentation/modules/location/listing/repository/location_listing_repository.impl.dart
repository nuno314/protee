part of 'location_listing_repository.dart';

class LocationListingRepositoryImpl extends LocationListingRepository {
  final _restApi = injector.get<AppApiService>().client;
  @override
  Future<List<UserLocation>> getSavedLocation() {
    return _restApi.getLocation();
  }

  @override
  Future<bool> removeLocation(String id) {
    return _restApi
        .removeLocation(id: id)
        .then((value) => value?.result ?? false);
  }

  @override
  Future<List<LocationHistory>> getLocationHistory(
    int offset,
    int limit,
    LocationFilter filter,
  ) {
    return _restApi
        .getLocationHistory(
          userId: filter.userId!,
          from: filter.from?.startDate.toUtc().toIso8601String(),
          to: filter.to?.endDate.toUtc().toIso8601String(),
          page: offset,
          take: limit,
        )
        .then((value) => value.data ?? []);
  }
}
