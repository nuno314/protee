part of 'location_listing_repository.dart';

class LocationListingRepositoryImpl extends LocationListingRepository {
  @override
  Future<List<Location>> getData(
    int offset,
    int limit,
  ) {
    return Future.value(<Location>[]);
  }
}