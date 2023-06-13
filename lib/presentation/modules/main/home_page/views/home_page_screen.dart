import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../di/di.dart';
import '../../../../../generated/assets.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/cache_network_image_wrapper.dart';
import '../../../../extentions/extention.dart';
import '../../../../route/route_list.dart';
import '../../../../theme/shadow.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/home_page_bloc.dart';
import 'ui_parts/background.dart';

part 'home_page.action.dart';
part 'ui_parts/family_statistic.dart';
part 'ui_parts/header.dart';
part 'ui_parts/map_view.dart';
part 'ui_parts/features.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends StateBase<HomePageScreen> {
  late Timer _timer;
  int idx = 0;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition? _kGooglePlex;

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  final _idxNotifier = ValueNotifier<int>(0);

  @override
  HomePageBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _idxNotifier.value = (_idxNotifier.value + 1) % 3;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _idxNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: _blocListener,
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              HomePageBackground(screenSize: device),
              _buildBody(state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(HomePageState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(state),
          _buildFamilyStatistic(state),
          _buildHomePageFeatures(state),
        ],
      ),
    );
  }
}
