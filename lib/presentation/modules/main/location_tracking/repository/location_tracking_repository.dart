import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/location.dart';
import '../../../../../di/di.dart';

part 'location_tracking_repository.impl.dart';

abstract class LocationTrackingRepository {
  Future<List<UserLocation>> getWarningLocationNearby(LatLng location);
}
