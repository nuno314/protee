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
}
