import '../../../../../data/models/location.dart';

part 'location_listing_repository.impl.dart';

abstract class LocationListingRepository {
  Future<List<Location>> getData(
    int offset,
    int limit,
  );
}