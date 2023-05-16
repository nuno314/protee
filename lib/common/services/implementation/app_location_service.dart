import 'package:geolocator/geolocator.dart' as locator;
import 'package:injectable/injectable.dart';

import '../../../common/utils.dart';
import '../../../data/data_source/data_repository.dart';
import '../../../data/data_source/local/preferences_helper/preferences_helper.dart';
import '../../../data/models/location.dart';
import '../../../di/di.dart';
import '../location_service.dart';

@Singleton(as: LocationService)
class LocationServiceImpl with DataRepository implements LocationService {
  late final localDataManager = injector.get<AppPreferenceData>();

  @override
  Future<Location?> getLastKnownLocation() async {
    final position = await _determinePosition();
    if (position == null) {
      return null;
    }
    return Location(
      lat: position.latitude,
      lng: position.longitude,
    );
  }

  Future<locator.Position?> _determinePosition() async {
    bool serviceEnabled;
    locator.LocationPermission permission;

    serviceEnabled = await locator.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      LogUtils.d('Location services are disabled.');
      return null;
    }
    permission = await locator.Geolocator.checkPermission();
    if (permission == locator.LocationPermission.denied) {
      permission = await locator.Geolocator.requestPermission();
      if (permission == locator.LocationPermission.denied) {
        LogUtils.d('Location permissions are denied');
        return null;
      }
    }

    if (permission == locator.LocationPermission.deniedForever) {
      LogUtils.d(
        '''Location permissions are permanently denied, we cannot request permissions.''',
      );
      return null;
    }
    return locator.Geolocator.getCurrentPosition();
  }

  @override
  Stream<locator.ServiceStatus> get serviceStatusStream =>
      locator.Geolocator.getServiceStatusStream();
}
