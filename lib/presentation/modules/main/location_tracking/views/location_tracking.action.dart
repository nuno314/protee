part of 'location_tracking_screen.dart';

extension LocationTrackingAction on _LocationTrackingScreenState {
  void _blocListener(BuildContext context, LocationTrackingState state) {
    hideLoading();
    _addMarkers(state.warningPlaces);
    if (state is CurrentLocationChangedState) {
      bloc.add(GetWarningLocationNearbyEvent());
    }
  }

  Future<void> _locateMe() async {
    LocationData? res;
    while (res == null) {
      res = await _locationService.getCurrentLocation();
    }
    await _animateCamera(LatLng(res.latitude!, res.longitude!));
  }

  Future<void> _animateCamera(LatLng location) async {
    final controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 14,
          target: location,
        ),
      ),
    );
    hideLoading();
  }

  void _addMarkers(List<UserLocation> locations) {
    final _markers = <MarkerId, Marker>{};
    for (final location in locations) {
      final marker = RippleMarker(
        markerId: MarkerId(location.id!),
        position: LatLng(location.lat!, location.long!),
        infoWindow: InfoWindow(title: location.name!),
      );
      _markers[MarkerId(location.id!)] = marker;
    }
    // ignore: invalid_use_of_protected_member
    setState(() {
      markers = _markers;
    });
  }
}
