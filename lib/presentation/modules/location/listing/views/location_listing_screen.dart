import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../common/utils.dart';
import '../../../../base/base.dart';
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

  @override
  late AppLocalizations trans;

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
    return SmartRefresherWrapper.build(
      enablePullDown: true,
      enablePullUp: state.canLoadMore,
      onLoading: loadMore,
      onRefresh: onRefresh,
      controller: _refreshController,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return const SizedBox();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemCount: state.data.length,
      ),
    );
  }
}
