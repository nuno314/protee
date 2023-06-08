import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/location.dart';
import '../../../../../di/di.dart';

part 'location_listing_repository.impl.dart';

abstract class LocationListingRepository {
  Future<List<UserLocation>> getData();
}
