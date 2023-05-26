part of 'add_location_screen.dart';

extension AddLocationAction on _AddLocationScreenState {
  void _blocListener(BuildContext context, AddLocationState state) {
    if (state.places.isNotEmpty) {
      showPredictions = true;
    }

    if (state is LocationChangedState) {
      _animateCamera(state.location!);
      _addMarker(place: state.place!);
    }
  }

  void _onTapLocation(LatLng latLng) {
    bloc.add(GetPLaceByLocation(Location.from(latLng: latLng)));
  }

  Future<void> _locateMe() async {
    showLoading();
    await context.read<LocationCubit>().let((cubit) async {
      final granted = await checkLocationPermission();
      if (granted == false) {
        await showNoticeDialog(
          context: context,
          message: trans.pleaseEnableGPS,
        );
      }
      if (cubit.isValidPlace != true) {
        await cubit.refreshLocation();
      }
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

  void _addMarker({GoogleMapPlace? place, LatLng? latLng}) {
    final marker = Marker(
      markerId: const MarkerId('current_location'),
      position: place != null
          ? LatLng(place.geometry!.location.lat!, place.geometry!.location.lng!)
          : latLng!,
      infoWindow: InfoWindow(
        title: place?.name ?? '${latLng!.latitude}, ${latLng.longitude}',
      ),
    );

    // ignore: invalid_use_of_protected_member
    setState(() {
      markers[const MarkerId('current_location')] = marker;
    });
  }

  void search(String? value) {
    bloc.add(SearchLocationEvent(value ?? ''));
  }

  void _onTapPlace(PlacePrediction place) {
    _addressController.text = place.description!;
    search('');
    bloc.add(GetLocationByPlaceIdEvent(place));
  }

  void _onBack() {
    Navigator.pop(context);
  }
}
