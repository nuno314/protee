import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/models/location.dart';
import '../../../../base/base.dart';
import '../../../../common_bloc/cubit/location_cubit.dart';
import '../../../../common_widget/export.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/theme_button.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/location_listing_bloc.dart';

part 'location_listing.action.dart';

class LocationListingScreen extends StatefulWidget {
  const LocationListingScreen({Key? key}) : super(key: key);

  @override
  State<LocationListingScreen> createState() => _LocationListingScreenState();
}

class _LocationListingScreenState extends StateBase<LocationListingScreen>
    with AfterLayoutMixin {
  @override
  LocationListingBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  late AppLocalizations trans;
  late final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  String? _mapStyle;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map/style.json').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return ScreenForm(
      headerColor: themeColor.primaryColor,
      titleColor: themeColor.white,
      title: trans.locationList.capitalizeFirstofEach(),
      child: BlocConsumer<LocationListingBloc, LocationListingState>(
        listener: _blocListener,
        builder: (context, state) {
          return _buildListing(state);
        },
      ),
    );
  }

  Widget _buildListing(LocationListingState state) {
    return Stack(
      children: [
        Expanded(
          child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            mapType: MapType.normal,
            markers: markers.values.toSet(),
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            compassEnabled: false,
            tiltGesturesEnabled: false,
            rotateGesturesEnabled: false,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          height: 234,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                _buildLocation(state.data.elementAt(index)),
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemCount: state.data.length,
          ),
        )
      ],
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(_mapStyle);
    _controller.complete(controller);
  }

  Widget _buildLocation(UserLocation location) {
    return InkWell(
      onTap: () => _onTapLocation(location),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        width: device.width / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: themeColor.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              location.name ?? '--',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ClipRRect(
              child: CachedNetworkImageWrapper.avatar(
                url: '',
                width: 120,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Text(
                location.description ?? '--',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ThemeButton.primary(
              onPressed: () => _onDeleteLocation(location),
              padding: const EdgeInsets.symmetric(vertical: 4),
              context: context,
              title: trans.delete,
              color: themeColor.red,
              constraints: const BoxConstraints(minHeight: 20.0),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    await _locateMe();
  }

  Future<void> _onTapLocation(UserLocation location) async {
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
