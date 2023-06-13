import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../../common/services/location_plugin_service.dart';
import '../../../../../common/utils.dart';
import '../../../../../data/models/location.dart';
import '../../../../../di/di.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/export.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/location_tracking_bloc.dart';

part 'location_tracking.action.dart';

class LocationTrackingScreen extends StatefulWidget {
  const LocationTrackingScreen({Key? key}) : super(key: key);

  @override
  State<LocationTrackingScreen> createState() => _LocationTrackingScreenState();
}

class _LocationTrackingScreenState extends StateBase<LocationTrackingScreen>
    with AfterLayoutMixin {
  @override
  LocationTrackingBloc get bloc => BlocProvider.of(context);

  final _location = injector.get<LocationPluginService>();

  late ThemeData _themeData;
  late final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  TextTheme get textTheme => _themeData.textTheme;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  final _locationService = injector.get<LocationPluginService>();

  @override
  late AppLocalizations trans;
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  String? _mapStyle;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map/style.json').then((string) {
      _mapStyle = string;
    });
    _location.onCurrentLocationChange((locationData) {
      if (mounted) {
        bloc.add(
          ChangeCurentLocation(
            LatLng(locationData.latitude!, locationData.longitude!),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return BlocConsumer<LocationTrackingBloc, LocationTrackingState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          title: trans.notification,
          headerColor: themeColor.primaryColor,
          titleColor: themeColor.white,
          showBackButton: false,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Animarker(
                mapId: _controller.future.then<int>((value) => value.mapId),
                curve: Curves.bounceInOut,
                duration: const Duration(milliseconds: 100),
                markers: markers.values.toSet(),
                child: GoogleMap(
                  initialCameraPosition: _kGooglePlex,
                  myLocationEnabled: true,
                  onMapCreated: _onMapCreated,
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  compassEnabled: false,
                  tiltGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                ),
              ),
              _buildWarnings(state),
            ],
          ),
        );
      },
    );
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    await _locateMe();
  }

  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(_mapStyle);
    _controller.complete(controller);
  }

  Widget _buildWarnings(LocationTrackingState state) {
    final warnings = state.warningPlaces;
    final hasWarning = warnings.isNotEmpty;

    return BoxColor(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      color: hasWarning ? themeColor.red : themeColor.green,
      borderRadius: BorderRadius.circular(16),
      child: hasWarning
          ? RichText(
              text: TextSpan(
                text: warnings.length > 1 ? trans.thereAre : trans.thereIs,
                style: TextStyle(
                  color: themeColor.white,
                ),
                children: [
                  TextSpan(
                    text: ' ${warnings.length} ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: themeColor.white,
                    ),
                  ),
                  TextSpan(
                    text: warnings.length > 1
                        ? trans.unsafeAreasNearby
                        : trans.unsafeAreaNearby,
                    style: TextStyle(
                      color: themeColor.white,
                    ),
                  ),
                ],
              ),
            )
          : Text(
              trans.safeArea,
              style: TextStyle(color: themeColor.white),
            ),
    );
  }
}
