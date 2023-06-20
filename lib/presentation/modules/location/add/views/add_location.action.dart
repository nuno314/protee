part of 'add_location_screen.dart';

extension AddLocationAction on _AddLocationScreenState {
  void _blocListener(BuildContext context, AddLocationState state) {
    hideLoading();

    if (state is LocationChangedState) {
      _animateCamera(state.location!);
      _addMarker(place: state.place!);
    } else if (state is AddLocationSuccessfullyState) {
      showNoticeDialog(
        context: context,
        message: trans.addLocationSuccessfully,
      );
    }
  }

  void _onAddLocation() {
    if (_nameController.text.isEmpty) {
      _nameController.setError('Vui lòng nhập tên địa điểm');
      return;
    }

    if (_addressController.text.isEmpty) {
      _addressController.setError('Vui lòng nhập vị trí');
      return;
    }

    showLoading();
    bloc.add(
      AddUserLocationEvent(
        name: _nameController.text,
        description: _addressController.text,
        location: bloc.state.location!,
      ),
    );
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
      markerId: MarkerId(place?.placeId ?? latLng.toString()),
      position: place != null
          ? LatLng(place.geometry!.location.lat!, place.geometry!.location.lng!)
          : latLng!,
      infoWindow: InfoWindow(
        title: place?.name ?? '${latLng!.latitude}, ${latLng.longitude}',
      ),
    );

    // ignore: invalid_use_of_protected_member
    setState(() {
      markers[MarkerId(place?.placeId ?? latLng.toString())] = marker;
    });
  }

  void search(String? value) {
    bloc.add(SearchLocationEvent(value ?? ''));
  }

  void _onTapPlace(GoogleMapPlace place) {
    search('');

    _addressController.text = place.formattedAddress;
    if (_nameController.text.isNullOrEmpty) {
      _nameController.text = place.name;
    }
    bloc.add(UpdatePlaceEvent(place));
  }

  void _onTapPrediction(PlacePrediction prediction) {
    search('');

    _addressController.text = prediction.description!;
    bloc.add(GetLocationByPlaceIdEvent(prediction));
  }

  void _onBack() {
    Navigator.pop(context);
  }
}
