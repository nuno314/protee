part of 'location_tracking_repository.dart';

class LocationTrackingRepositoryImpl extends LocationTrackingRepository {
  final _restApi = injector.get<AppApiService>().client;
  final _mapApi = injector.get<AppApiService>().locationRepository;

  @override
  Future<List<UserLocation>> getWarningLocationNearby(LatLng location) {
    return _restApi.getLocationNearby(
      lat: location.latitude,
      lng: location.longitude,
    );
  }

  @override
  Future<List<UserLocation>> getPlaces() {
    return _restApi.getLocation();
  }

  @override
  Future<List<GoogleRoute>?> getDirections(
    String origin,
    String destination,
  ) async {
    return _mapApi
        .getDirections(
          origin: 'place_id:$origin',
          destination: 'place_id:$destination',
        )
        .then((value) => value.routes ?? []);
  }

  @override
  Future<GoogleMapPlace?> getGeocode(LatLng latLng) {
    return _mapApi
        .getGeocode(latlng: latLng.comma)
        .then((value) => value.results.firstOrNull);
  }

  @override
  Future<List<User>> getChildren() {
    return _restApi.getFamilyMembers().then((value) {
      return value
              ?.where(
                (element) =>
                    element.user != null && element.role == FamilyRole.child,
              )
              .map((e) => e.user!)
              .toList() ??
          [];
    });
  }

  @override
  Future<ChildLastLocation?> getChildLastLocation(String id) {
    return _restApi.getLastLocation(id).then((value) => value?.result);
  }
}
