import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../data/models/location.dart';
import '../repository/location_tracking_repository.dart';

part 'location_tracking_interactor.impl.dart';

abstract class LocationTrackingInteractor {
  Future<List<UserLocation>> getWarningLocationNearby(LatLng location);
}
