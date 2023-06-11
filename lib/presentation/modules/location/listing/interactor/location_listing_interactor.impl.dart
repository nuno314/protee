part of 'location_listing_interactor.dart';

class LocationListingInteractorImpl extends LocationListingInteractor {
  final LocationListingRepository _repository;

  LocationListingInteractorImpl(this._repository);

  @override
  Future<List<UserLocation>> getData() {
    return _repository.getData();
  }

  @override
  Future<bool> removeLocation(String id) {
    return _repository.removeLocation(id);
  }
}
