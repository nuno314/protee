import 'package:geolocator/geolocator.dart';

import '../../data/models/location.dart';

abstract class LocationService {
   Stream<ServiceStatus> get serviceStatusStream;

  Future<Location?> getLastKnownLocation();
}
