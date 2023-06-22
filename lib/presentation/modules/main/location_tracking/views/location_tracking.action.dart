part of 'location_tracking_screen.dart';

extension LocationTrackingAction on _LocationTrackingScreenState {
  void _blocListener(BuildContext context, LocationTrackingState state) {
    // hideLoading();
    _addWarningMarkers(state.warningPlaces);
    _addMarkers(state.places);
    if (state is CurrentLocationChangedState) {
      bloc.add(GetWarningLocationNearbyEvent());
    } else if (state is GetRouteState) {
      if (state.bounds != null) {
        final southwest = LatLng(
          state.bounds!.southwest!.lat!,
          state.bounds!.southwest!.lng!,
        );
        final northeast = LatLng(
          state.bounds!.northeast!.lat!,
          state.bounds!.northeast!.lng!,
        );
        _zoomOut(southwest, northeast);
      }
      state.routes.forEach(computePath);
    } else if (state is ChildrenInitialState) {
      bloc.add(GetChildrenLastLocationEvent());
    } else if (state is ChildrenLastLocationState) {
      _addLastLocation(state.lastLocations);
    }
  }

  Future<void> _locateMe() async {
    showLoading();
    LocationData? res;
    while (res == null) {
      res = await _locationService.getCurrentLocation();
    }
    bloc.add(
      ChangeCurentLocation(
        LatLng(res.latitude!, res.longitude!),
      ),
    );
    await _animateCamera(LatLng(res.latitude!, res.longitude!));
    hideLoading();
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

  void _addWarningMarkers(List<UserLocation> locations) {
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
      warningMarkers = _markers;
    });
  }

  void _addMarkers(List<UserLocation> places) {
    final _markers = <MarkerId, Marker>{};
    for (final location in places) {
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

  void _onTapSearch() {
    Navigator.pushNamed(context, RouteList.searchRoute).then((value) {
      if (value is String) {
        bloc.add(
          GetDirectionsEvent(
            destination: value,
          ),
        );
      }
    });
  }

  Future<void> computePath(List<LatLng> routes) async {
    // ignore: invalid_use_of_protected_member
    setState(() {
      polyline = [
        Polyline(
          polylineId: const PolylineId('route'),
          visible: true,
          points: routes,
          width: 4,
          color: Colors.blue,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap,
        ),
      ];
      final destination = Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(routes.last.latitude, routes.last.longitude),
      );
      markers.addAll({const MarkerId('destination'): destination});
    });
  }

  Future<void> _zoomCameraOut(List<LatLng> routes) async {
    final southwest = routes.first.latitude <= routes.last.latitude
        ? routes.first
        : routes.last;

    final northEast = routes.first.latitude <= routes.last.latitude
        ? routes.last
        : routes.first;

    final bounds = LatLngBounds(southwest: southwest, northeast: northEast);
    final updatedCamera = CameraUpdate.newLatLngBounds(bounds, 100);

    final controller = await _controller.future;
    await controller.animateCamera(updatedCamera);
  }

  Future<void> _zoomOut(LatLng southwest, LatLng northeast) async {
    final bounds = LatLngBounds(southwest: southwest, northeast: northeast);
    final updatedCamera = CameraUpdate.newLatLngBounds(bounds, 80);
    final controller = await _controller.future;
    await controller.animateCamera(updatedCamera);
  }

  Future<void> _addLastLocation(List<ChildLastLocation?> locations) async {
    var cnt = 0;
    final _markers = <MarkerId, Marker>{};
    for (final location in locations) {
      if (location == null) {
        continue;
      }
      final avatar = location.user!.avatar!;
      final bytes = (await NetworkAssetBundle(Uri.parse(avatar)).load(avatar))
          .buffer
          .asUint8List();
      final smallimg = resizeImage(bytes, 150, 150) ?? bytes;

      final marker = Marker(
        onTap: () async => _onTapChild(location),
        markerId: MarkerId(location.user!.name!),
        position: LatLng(
          double.parse(location.currentLat!),
          double.parse(location.currentLong!),
        ), //position of marker
        infoWindow: InfoWindow(
          title: location.user!.name!,
        ),
        icon: BitmapDescriptor.fromBytes(smallimg),
      );
      _markers.addAll({MarkerId(location.user!.name!): marker});
      cnt++;
    }
    if (cnt > 1) {
      await _zoomCameraOut(
        locations
            .where((element) => element != null)
            .map(
              (location) => LatLng(
                double.parse(location!.currentLat!),
                double.parse(location.currentLong!),
              ),
            )
            .toList(),
      );
    } else {
      final child = locations.firstWhere((element) => element != null);
      await _animateCamera(
        LatLng(
          double.parse(child!.currentLat!),
          double.parse(child.currentLong!),
        ),
      );
    }
    setState(() {
      markers = _markers;
    });
  }

  Uint8List? resizeImage(Uint8List data, int? width, int? height) {
    final img = IMG.decodeImage(data);
    final resized = IMG.copyResize(img!, width: width, height: height);
    return Uint8List.fromList(IMG.encodePng(resized));
  }

  Future<void> _onTapChild(ChildLastLocation location) async {
    final user = location.user;
    await showModal(
      context,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: CachedNetworkImageWrapper.avatar(
                url: user?.avatar ?? '',
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              user?.name ?? '--',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              location.createdAt?.toLocalHHnnddmmyyWithCommas() ?? '--',
            ),
          ],
        ),
      ),
      title: trans.latestPosition,
    );
  }
}
