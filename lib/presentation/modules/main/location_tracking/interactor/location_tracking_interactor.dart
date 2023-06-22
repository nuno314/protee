import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../data/models/location.dart';
import '../../../../../data/models/user.dart';
import '../bloc/location_tracking_bloc.dart';
import '../repository/location_tracking_repository.dart';

part 'location_tracking_interactor.impl.dart';

abstract class LocationTrackingInteractor {
  Future<List<UserLocation>> getWarningLocationNearby(LatLng location);

  Future<List<UserLocation>> getPlaces();

  Future<RoutesInfo> getDirections(
    String origin,
    String destination,
    List<UserLocation> warnings,
  );

  Future<String?> getGeocode(LatLng latLng);

  Future<List<User>> getChildren();

  Future<ChildLastLocation?> getChildLastLocation(String id);
}
