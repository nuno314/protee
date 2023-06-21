import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show ByteData, NetworkAssetBundle, Uint8List, rootBundle;
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart' as IMG;
import 'package:location/location.dart';

import '../../../../../common/services/location_plugin_service.dart';
import '../../../../../common/utils.dart';
import '../../../../../data/models/location.dart';
import '../../../../../data/models/user.dart';
import '../../../../../di/di.dart';
import '../../../../../generated/assets.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/export.dart';
import '../../../../extentions/extention.dart';
import '../../../../route/route_list.dart';
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

  Map<MarkerId, Marker> warningMarkers = <MarkerId, Marker>{};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<Polyline> polyline = [];
  List<LatLng> routeCoords = [];

  final _locationService = injector.get<LocationPluginService>();

  late Timer _timer;

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

    _timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      if (mounted) {
        if (bloc.state.isParent != true) {
          _location.onCurrentLocationChange((location) {
            bloc.add(
              ChangeCurentLocation(
                LatLng(location.latitude!, location.longitude!),
              ),
            );
          });
        }
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
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 20, 8),
              child: InkWell(
                onTap: _onTapSearch,
                child: SvgPicture.asset(
                  Assets.svg.icSearch,
                  color: themeColor.white,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ],
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Animarker(
                mapId: _controller.future.then<int>((value) => value.mapId),
                curve: Curves.bounceInOut,
                duration: const Duration(milliseconds: 100),
                markers: warningMarkers.values.toSet(),
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
                  markers: markers.values.toSet(),
                  polylines: polyline.toSet(),
                ),
              ),
              state.isParent ? const SizedBox() : _buildWarnings(state),
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

  Widget _buildChild(
    User child,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: themeColor.green, width: 3),
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImageWrapper.avatar(
          url: child.avatar ?? '',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
