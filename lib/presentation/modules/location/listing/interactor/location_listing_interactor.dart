import '../../../../../data/models/location.dart';
import '../../../../../domain/entities/pagination.entity.dart';
import '../../../../../domain/use_case/listing_use_case.dart';
import '../repository/location_listing_repository.dart';

part 'location_listing_interactor.impl.dart';

abstract class LocationListingInteractor {
  Pagination get pagination;

  Future<List<UserLocation>> getData();

  Future<List<UserLocation>> loadMoreData();
}
