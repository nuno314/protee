import 'package:location/location.dart';

abstract class LocationPluginService {
  Stream<LocationData> get locationStream;

  Future<LocationData?> getCurrentLocation();

  void onCurrentLocationChange(
    void Function(LocationData) onChanged,
  );
}
