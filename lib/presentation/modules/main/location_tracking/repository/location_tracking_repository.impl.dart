part of 'location_tracking_repository.dart';

class LocationTrackingRepositoryImpl extends LocationTrackingRepository {
  final _restApi = injector.get<AppApiService>().client;

  @override
  Future<List<UserLocation>> getWarningLocationNearby(LatLng location) {
    return _restApi.getLocationNearby(
      lat: location.latitude,
      lng: location.longitude,
    );
  }
}
