part of 'location_listing_interactor.dart';

class LocationListingInteractorImpl extends LocationListingInteractor {
  final LocationListingRepository _repository;

  LocationListingInteractorImpl(this._repository);

  late final _listingUsecase = ListingUseCase<Location, dynamic>(
    (offset, limit, [param]) => _repository.getData(offset, limit),
  );

  @override
  Pagination get pagination => _listingUsecase.pagination;

  @override
  Future<List<Location>> getData() {
    return _listingUsecase.getData();
  }

  @override
  Future<List<Location>> loadMoreData() {
    return _listingUsecase.loadMoreData();
  }
}
