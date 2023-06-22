part of 'location_tracking_interactor.dart';

class LocationTrackingInteractorImpl extends LocationTrackingInteractor {
  final LocationTrackingRepository _repository;

  LocationTrackingInteractorImpl(this._repository);

  @override
  Future<List<UserLocation>> getWarningLocationNearby(LatLng location) {
    return _repository.getWarningLocationNearby(location);
  }

  @override
  Future<List<UserLocation>> getPlaces() {
    return _repository.getPlaces();
  }

  @override
  Future<RoutesInfo> getDirections(
    String origin,
    String destination,
    List<UserLocation> warnings,
  ) async {
    final res = await _repository.getDirections(origin, destination);
    if (res == null) {
      return const RoutesInfo();
    }

    final list = <List<LatLng>>[];
    var bound = res.first.bounds;
    for (final route in res) {
      final coordList = route.legs!
          .map((e) => e.steps)
          .expand((element) => element!)
          .toList()
          .map((e) => e.end)
          .toList()
          .map((e) => LatLng(e!.lat!, e.lng!))
          .toList();
      list.add(coordList);
      bound = bound?.bigger(route.bounds);
    }
    return RoutesInfo(
      routes: list,
      bounds: bound,
    );
  }

  @override
  Future<String?> getGeocode(LatLng latLng) async {
    final res = await _repository.getGeocode(latLng);

    return res?.placeId;
  }

  @override
  Future<List<User>> getChildren() {
    return _repository.getChildren();
  }

  @override
  Future<ChildLastLocation?> getChildLastLocation(String id) {
    return _repository.getChildLastLocation(id);
  }
}
