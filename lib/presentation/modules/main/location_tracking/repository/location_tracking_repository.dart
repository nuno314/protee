import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/utils/extensions.dart';
import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/location.dart';
import '../../../../../data/models/response.dart';
import '../../../../../data/models/route.dart';
import '../../../../../data/models/user.dart';
import '../../../../../di/di.dart';

part 'location_tracking_repository.impl.dart';

abstract class LocationTrackingRepository {
  Future<List<UserLocation>> getWarningLocationNearby(LatLng location);

  Future<List<UserLocation>> getPlaces();

  Future<List<GoogleRoute>?> getDirections(String origin, String destination);

  Future<GoogleMapPlace?> getGeocode(LatLng latLng);

  Future<List<User>> getChildren();

  Future<ChildLastLocation?> getChildLastLocation(String id);
}
