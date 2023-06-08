part of 'location_tracking_interactor.dart';

class LocationTrackingInteractorImpl extends LocationTrackingInteractor {
  final LocationTrackingRepository _repository;

  LocationTrackingInteractorImpl(this._repository);

  @override
  Future<List<UserLocation>> getWarningLocationNearby(LatLng location) {
    return _repository.getWarningLocationNearby(location);
  }
}
