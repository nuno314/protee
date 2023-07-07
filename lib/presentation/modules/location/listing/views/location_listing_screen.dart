import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/models/location.dart';
import '../../../../../domain/entities/location_filter.entity.dart';
import '../../../../../generated/assets.dart';
import '../../../../base/base.dart';
import '../../../../common_bloc/cubit/location_cubit.dart';
import '../../../../common_widget/export.dart';
import '../../../../common_widget/smart_refresher_wrapper.dart';
import '../../../../common_widget/tab_page_widget.dart';
import '../../../../extentions/extention.dart';
import '../../../../route/route_list.dart';
import '../../../../theme/theme_button.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/location_listing_bloc.dart';

part 'location_listing.action.dart';

class LocationListingScreen extends StatefulWidget {
  final int? tabIdx;
  const LocationListingScreen({
    Key? key,
    this.tabIdx,
  }) : super(key: key);

  @override
  State<LocationListingScreen> createState() => _LocationListingScreenState();
}

class _LocationListingScreenState extends StateBase<LocationListingScreen>
    with AfterLayoutMixin {
  final PageController _pageController = PageController();
  final tabBarKey = GlobalKey();

  TabController? get _tabController =>
      tabBarKey.currentContext?.let(DefaultTabController.of);

  final _historyRC = RefreshController();

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

  final _showFilter = ValueNotifier<bool>(false);

  @override
  void hideLoading() {
    _historyRC
      ..refreshCompleted()
      ..loadComplete();
    super.hideLoading();
  }

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
      onBack: () {
        hideLoading();
        Navigator.pop(context);
      },
      title: trans.locationList.capitalizeFirstofEach(),
      actions: [
        ValueListenableBuilder<bool>(
          valueListenable: _showFilter,
          builder: (context, value, child) {
            if (value) {
              return InkWell(
                onTap: _openFilter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: SvgPicture.asset(
                    Assets.svg.icFilter,
                    color: themeColor.white,
                    width: 24,
                    height: 24,
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
      child: BlocConsumer<LocationListingBloc, LocationListingState>(
        listener: _blocListener,
        builder: (context, state) {
          return _buildPage(state);
        },
      ),
    );
  }

  Widget _buildPage(LocationListingState state) {
    if (!state.isParent) {
      return _buildListing(state);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DefaultTabController(
          length: 2,
          child: TabBox(
            key: tabBarKey,
            child: TabBar(
              onTap: _onTabChange,
              tabs: [
                Tab(text: trans.list),
                Tab(text: trans.history),
              ],
            ),
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            allowImplicitScrolling: true,
            children: [
              _buildListing(state),
              _buildHistories(state),
            ],
          ),
        )
      ],
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
          markers: markers.values.toSet(),
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
    final canDelete = location.status != UserLocationStatus.published &&
        (bloc.state.isParent || bloc.state.user!.id == location.user!.id);
    final createdByServer = location.user == null;
    return InkWell(
      onTap: () => _onTapLocation(location),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        width: device.width / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: createdByServer ? Colors.yellow.shade300 : themeColor.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BoxColor(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      location.name ?? '--',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade900,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (createdByServer == false)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImageWrapper.avatar(
                        url: location.user?.avatar ?? '',
                        width: 24,
                        height: 24,
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  location.description ?? '--',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (canDelete)
              ThemeButton.primary(
                onPressed: () => _onDeleteLocation(location),
                padding: const EdgeInsets.symmetric(vertical: 4),
                context: context,
                title: trans.delete,
                color: themeColor.red,
                constraints: const BoxConstraints(minHeight: 20.0),
              ),
            if (createdByServer)
              Column(
                children: [
                  Text(
                    trans.suggestedBy,
                    style: TextStyle(
                      fontSize: 10,
                      color: themeColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImageWrapper.avatar(
                      url: '',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    if (widget.tabIdx != null) {
      _onTabChange(widget.tabIdx!);
      _tabController?.animateTo(widget.tabIdx!);
    }
    await _locateMe();
  }

  Widget _buildHistories(LocationListingState state) {
    return SmartRefresherWrapper(
      controller: _historyRC,
      enablePullUp: state.canLoadMoreHistory,
      onRefresh: _onRefreshHistories,
      onLoading: _onLoadingHistories,
      child: state.locationHistories.isEmpty
          ? EmptyData(
              icon: Assets.svg.icEmptyLocationHistory,
              emptyMessage: trans.emptyHistory,
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemBuilder: (context, index) => _buildLocationHistory(
                state.locationHistories.elementAt(index),
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: state.locationHistories.length,
            ),
    );
  }

  Widget _buildLocationHistory(LocationHistory item) {
    return InkWell(
      onTap: () => _onTapLocationHistory(item),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  themeColor.primaryColorLight,
                  themeColor.primaryColor,
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item.location?.name ?? '--',
                    style: TextStyle(
                      color: themeColor.white,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                BoxColor(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  color: themeColor.white,
                  border: Border.all(color: themeColor.transaprent),
                  borderRadius: BorderRadius.zero,
                  child: Text(
                    item.distance == null ? '--' : '${item.distance!}m',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: themeColor.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: themeColor.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHistoryInfo(
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImageWrapper.avatar(
                      url: item.user?.avatar ?? '--',
                      width: 16,
                      height: 16,
                      fit: BoxFit.cover,
                    ),
                  ),
                  item.user?.name ?? '--',
                ),
                const SizedBox(height: 6),
                _buildHistoryInfo(
                  SvgPicture.asset(
                    Assets.svg.icClock,
                    color: themeColor.gray8C,
                    width: 16,
                    height: 16,
                  ),
                  item.createdAt?.toLocalHHnnddmmyyWithCommas() ?? '--',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryInfo(Widget icon, String content) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            content,
            style: const TextStyle(fontSize: 12),
          ),
        )
      ],
    );
  }
}
