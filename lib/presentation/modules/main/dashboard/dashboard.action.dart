part of 'dashboard_screen.dart';

extension DashboardAction on _DashboardScreenState {
  Future<bool> onNavigationPressed(int idx) async {
    if (!_cubit.isLoggedIn) {
      showLoginNoticeDialog(onSuccess: () => onNavigationPressed(idx));
      return false;
    }
    _cubit.navigateTo(idx);
    return true;
  }

  void _didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      syncData();
      themeColor.setLightStatusBar();
    }
  }

  void _cubitListener(BuildContext context, DashboardState state) {
    _pageController.jumpToPage(
      state.index,
    );
  }

  void _updateOnesignal() {
    final onesignal = injector.get<OneSignalNotificationService>();
    // ..setTags({'role': Config.instance.appConfig.platformRole});
    if (_cubit.isLoggedIn) {
      // onesignal.onNotificationOpened(
      //   (n) => AppNotificationRoute.onOpened(context, n),
      // );
      // final userRepo = injector.get<UserRepository>();
      // (userRepo.currentUser == null
      //         ? userRepo.onUserChanged.first
      //         : Future.value(userRepo.currentUser))
      //     .then((user) {
      //   if (user?.id != null) {
      //     onesignal.setUserId(user!.id!);
      //   }
      // });
    } else {
      onesignal.removeUserId();
    }
  }
}
