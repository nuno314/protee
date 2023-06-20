part of 'location_listing_interactor.dart';

class LocationListingInteractorImpl extends LocationListingInteractor {
  final LocationListingRepository _repository;

  LocationListingInteractorImpl(this._repository);

  @override
  Future<List<UserLocation>> getSavedLocations() {
    return _repository.getSavedLocation();
  }

  @override
  Future<bool> removeLocation(String id) {
    return _repository.removeLocation(id);
  }

  late final _listingUsecase = ListingUseCase<LocationHistory, dynamic>(
    (offset, limit, [param]) => _repository.getLocationHistory(
      offset,
      limit,
      param!
    ),
  );

  @override
  Pagination get pagination => _listingUsecase.pagination;

  @override
  Future<List<LocationHistory>> getData(
    LocationFilter filter,
  ) {
    return _listingUsecase.getData(filter);
  }

  @override
  Future<List<LocationHistory>> loadMoreData(
    LocationFilter filter,
  ) {
    return _listingUsecase.loadMoreData(filter);
  }
}
