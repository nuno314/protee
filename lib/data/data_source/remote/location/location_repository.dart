import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../models/place_prediction.dart';
import '../../../models/response.dart';
import 'api_contract.dart';

part 'location_repository.g.dart';

@RestApi()
abstract class LocationRepository {
  factory LocationRepository(Dio dio, {String baseUrl}) = _LocationRepository;

  @GET('placeTextSearch')
  Future<GoogleMapAPIReponse> placeTextSearch(
    @Query('query') String query,
    @Query('key') String apiKey,
  );

  @GET(GoogleMapApiContract.placeAutocomplete)
  Future<GoogleMapAPIReponse> getAutoComplete({
    @Query('input') String input = '',
    @Query('language') String language = 'vi_VN',
    @Query('types') String types= 'geocode',
  });
}
