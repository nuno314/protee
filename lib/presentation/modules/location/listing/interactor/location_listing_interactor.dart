import '../../../../../data/models/location.dart';
import '../../../../../domain/entities/location_filter.entity.dart';
import '../../../../../domain/entities/pagination.entity.dart';
import '../../../../../domain/use_case/listing_use_case.dart';
import '../repository/location_listing_repository.dart';

part 'location_listing_interactor.impl.dart';

abstract class LocationListingInteractor {
  Future<List<UserLocation>> getSavedLocations();

  Future<bool> removeLocation(String id);

  Pagination get pagination;

  Future<List<LocationHistory>> getData(
    LocationFilter filter,
  );

  Future<List<LocationHistory>> loadMoreData(
    LocationFilter filter,
  );
}
