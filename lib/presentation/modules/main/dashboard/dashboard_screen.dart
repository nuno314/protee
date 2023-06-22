import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/utils.dart';
import '../../../../data/data_source/remote/app_api_service.dart';
import '../../../../di/di.dart';
import '../../../../generated/assets.dart';
import '../../../base/base.dart';
import '../../../common_widget/export.dart';
import '../../../extentions/extention.dart';
import '../../../theme/theme_color.dart';
import '../../notification/bloc/notification_bloc.dart';
import '../../notification/views/notification_screen.dart';
import '../account/bloc/account_bloc.dart';
import '../account/views/account_screen.dart';
import '../home_page/home_page.dart';
import '../location_tracking/location_tracking.dart';
import 'cubit/dashboard_cubit.dart';
import 'dashboard_constants.dart';

part 'dashboard.action.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends StateBase<DashboardScreen>
    with AfterLayoutMixin, WidgetsBindingObserver {
  DashboardCubit get _cubit => BlocProvider.of(context);

  final _pageController = PageController();

  StreamSubscription? connectivitySub;
  @override
  void afterFirstLayout(BuildContext context) {
    syncData();
    _cubit
      ..navigateTo(DashboardPage.home.index)
      ..markLaunched();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    connectivitySub = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if ([
        ConnectivityResult.wifi,
        ConnectivityResult.ethernet,
        ConnectivityResult.mobile
      ].contains(result)) {
        syncData();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    connectivitySub?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _didChangeAppLifecycleState(state);
  }

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    final _user = injector.get<AppApiService>().localDataManager.currentUser;
    return Scaffold(
      body: Container(
        color: themeColor.transaprent,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                KeepAliveWidget(
                  child: BlocProvider(
                    create: (context) => HomePageBloc(user: _user),
                    child: const HomePageScreen(),
                  ),
                ),
                KeepAliveWidget(
                  child: BlocProvider(
                    create: (context) => LocationTrackingBloc(_user),
                    child: const LocationTrackingScreen(),
                  ),
                ),
                KeepAliveWidget(
                  child: BlocProvider(
                    create: (context) => NotificationBloc(),
                    child: const NotificationScreen(),
                  ),
                ),
                KeepAliveWidget(
                  child: BlocProvider(
                    create: (context) => AccountBloc(user: _user),
                    child: const AccountScreen(),
                  ),
                ),
              ],
            ),
            BlocConsumer<DashboardCubit, DashboardState>(
              listener: _cubitListener,
              bloc: _cubit,
              builder: (context, state) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CustomBottomNavigationBar(
                  items: [
                    BottomBarItemData(
                      icon: _buildBottomBarIcon(
                        asset: Assets.svg.icHome,
                      ),
                      selectedIcon: _buildBottomBarIcon(
                        asset: Assets.svg.icHomeFilled,
                      ),
                    ),
                    BottomBarItemData(
                      icon: _buildBottomBarIcon(
                        asset: Assets.svg.icMarker,
                      ),
                      selectedIcon: _buildBottomBarIcon(
                        asset: Assets.svg.icMarkerFilled,
                      ),
                    ),
                    BottomBarItemData(
                      icon: _buildBottomBarIcon(
                        asset: Assets.svg.icNoti,
                      ),
                      selectedIcon: _buildBottomBarIcon(
                        asset: Assets.svg.icNotiFilled,
                      ),
                    ),
                    BottomBarItemData(
                      icon: _buildBottomBarIcon(
                        asset: Assets.svg.icAccount,
                      ),
                      selectedIcon: _buildBottomBarIcon(
                        asset: Assets.svg.icAccountFilled,
                      ),
                    ),
                  ],
                  selectedIdx: state.index,
                  onItemSelection: onNavigationPressed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBarIcon({
    required String asset,
    void Function()? ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        child: SvgPicture.asset(
          asset,
          width: 24,
          height: 24,
        ),
      ),
    );
  }

  @override
  AppBlocBase? get bloc => null;
}
