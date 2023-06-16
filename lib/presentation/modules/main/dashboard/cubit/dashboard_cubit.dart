import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';

import '../../../../../common/services/auth_service.dart';
import '../../../../../data/data_source/local/local_data_manager.dart';
import '../../../../../di/di.dart';
import '../dashboard_constants.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  bool get isLoggedIn => injector.get<AuthService>().isSignedIn;

  DashboardCubit() : super(DashboardHome());

  void navigateTo(int idx) {
    if (idx == DashboardPage.home.index) {
      emit(DashboardHome());
    } else if (idx == DashboardPage.location.index) {
      emit(DashboardLocation());
    } else if (idx == DashboardPage.notification.index) {
      emit(DashboardNotification());
    } else if (idx == DashboardPage.account.index) {
      emit(DashboardAccount());
    } else {
      assert(false, 'Page with idx $idx not found!');
    }
  }

  void markLaunched() {
    injector.get<LocalDataManager>().markLaunched();
  }

  List<DashboardState> get dashboardStates => [
        DashboardHome(),
        DashboardLocation(),
        DashboardNotification(),
        DashboardAccount(),
      ];

  /// -1: Unsupported
  ///  0: login required
  ///  1: navigate success
  int navigateByRoute(String route) {
    final state = dashboardStates.firstWhereOrNull((e) => e.route == route);
    if (state == null) {
      return -1;
    }
    if (isLoggedIn) {
      navigateTo(state.index);
      return 1;
    } else {
      return 0;
    }
  }
}
