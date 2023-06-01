import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/models/location.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/box_color.dart';
import '../../../../common_widget/cache_network_image_wrapper.dart';
import '../../../../common_widget/forms/screen_form.dart';
import '../../../../common_widget/smart_refresher_wrapper.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/location_listing_bloc.dart';

part 'location_listing.action.dart';

class LocationListingScreen extends StatefulWidget {
  const LocationListingScreen({Key? key}) : super(key: key);

  @override
  State<LocationListingScreen> createState() => _LocationListingScreenState();
}

class _LocationListingScreenState extends StateBase<LocationListingScreen> {
  final _refreshController = RefreshController(initialRefresh: true);

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
  @override
  void hideLoading() {
    _refreshController
      ..refreshCompleted()
      ..loadComplete();
    super.hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return ScreenForm(
      headerColor: themeColor.primaryColor,
      titleColor: themeColor.white,
      title: 'Danh sách địa điểm'.capitalizeFirstofEach(),
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
        GoogleMap(
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
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          height: 234,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _buildLocation(Location()),
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemCount: 10,
          ),
        )
      ],
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Widget _buildLocation(Location location) {
    return BoxColor(
      color: themeColor.white,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          const Text(
            'Địa điểm 1',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            child: CachedNetworkImageWrapper.item(
              url: '',
              width: 120,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Vị trí',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
