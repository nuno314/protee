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
    } else if (state is FilterUpdatedState) {
      _historyRC.requestRefresh();
    }
  }

  void _onRefreshHistories() {
    bloc.add(GetLocationHistoryEvent());
  }

  void _onLoadingHistories() {
    bloc.add(LoadMoreLocationHistoryEvent());
  }

  void _addMarkers(List<UserLocation> locations) {
    final _markers = <MarkerId, Marker>{};
    for (final location in locations) {
      if (location.lat == null || location.long == null) {
        continue;
      }
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
        // return;
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
            location.lat! - 0.005,
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
    _addMarkers([location]);
    await _animateCamera(
      Location.from(
        latLng: LatLng(
          location.lat!,
          location.long!,
        ),
      ),
    );
  }

  void _openFilter() {
    Navigator.pushNamed(
      context,
      RouteList.locationFilter,
      arguments: bloc.state.filter,
    ).then((value) {
      if (value is LocationFilter) {
        bloc.add(UpdateFilterEvent(value));
      }
    });
  }

  void _onTabChange(int value) {
    _pageController.jumpToPage(value);
    _showFilter.value = value == 1;
  }

  void _onTapLocationHistory(LocationHistory item) {
    _tabController?.animateTo(0);
    _onTabChange(0);
    _onTapLocation(item.location!);
  }
}
