import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/location.dart';
import '../../../../../di/di.dart';
import '../../../../../domain/entities/location_filter.entity.dart';
import '../../../../../common/utils.dart';

part 'location_listing_repository.impl.dart';

abstract class LocationListingRepository {
  Future<List<UserLocation>> getSavedLocation();

  Future<bool> removeLocation(String id);

  Future<List<LocationHistory>> getLocationHistory(
    int offset,
    int limit,
    LocationFilter filter,
  );
}
