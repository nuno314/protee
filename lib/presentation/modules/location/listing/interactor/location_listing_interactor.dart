import '../../../../../data/models/location.dart';
import '../repository/location_listing_repository.dart';

part 'location_listing_interactor.impl.dart';

abstract class LocationListingInteractor {
  Future<List<UserLocation>> getData();

  Future<bool> removeLocation(String id);
}
