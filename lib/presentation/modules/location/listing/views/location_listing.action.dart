part of 'location_listing_screen.dart';

extension LocationListingAction on _LocationListingScreenState {
  void _blocListener(BuildContext context, LocationListingState state) {
    hideLoading();

    _addMarkers(state.data);
    if (state is LocationUpdatedState) {
      showLoading();
      bloc.add(GetLocationsEvent());
    } else if (state is RemoveLocationSuccessfully) {
      showNoticeDialog(
        context: context,
        message: trans.removeLocationSuccessfully,
      ).then((value) {
        showLoading();
        bloc.add(GetLocationsEvent());
      });
    }
  }

  void _addMarkers(List<UserLocation> locations) {
    final _markers = <MarkerId, Marker>{};
    for (final location in locations) {
      final marker = Marker(
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

  Future<void> _locateMe() async {
    showLoading();
    await context.read<LocationCubit>().let((cubit) async {
      final granted = await checkLocationPermission();
      if (granted == false) {
        hideLoading();
        await showNoticeDialog(
          context: context,
          message: trans.pleaseEnableGPS,
        );
        return;
      }
      if (cubit.isValidPlace != true) {
        await cubit.refreshLocation();
      }
      bloc.add(UpdateCurrentEvent(cubit.state.currentPlace!.location!));
      hideLoading();
      await _animateCamera(cubit.state.currentPlace!.location!);
    });
  }

  Future<void> _animateCamera(Location location) async {
    final controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 14,
          target: LatLng(
            location.lat!,
            location.lng!,
          ),
        ),
      ),
    );
  }

  Future<void> _onDeleteLocation(UserLocation location) async {
    await showNoticeConfirmDialog(
      context: context,
      message: trans.confirmRemoveLocation,
      title: trans.inform,
      onConfirmed: () {
        showLoading();
        bloc.add(
          RemoveLocationEvent(location),
        );
      },
    );
  }

    Future<void> _onTapLocation(UserLocation location) async {
    print(location.lat);
    print(location.long);
    await _animateCamera(
      Location.from(
        latLng: LatLng(
          location.lat!,
          location.long!,
        ),
      ),
    );
  }
}
