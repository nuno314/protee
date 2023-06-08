import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

import '../../../data/data_source/data_repository.dart';
import '../location_plugin_service.dart';

@Singleton(as: LocationPluginService)
class LocationPluginServiceImpl
    with DataRepository
    implements LocationPluginService {
  final Location _location = Location();

  @override
  Stream<LocationData> get locationStream => _location.onLocationChanged;

  @override
  Future<LocationData?> getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    await _location.enableBackgroundMode(enable: true);
    return _location.getLocation();
  }

  @override
  void onCurrentLocationChange(
    void Function(LocationData) onChanged,
  ) {
    locationStream.listen(onChanged);
  }
}
