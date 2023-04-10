part of 'dashboard_cubit.dart';

abstract class DashboardState {
  final int index;

  // True => status bar color is white
  // False => status bar color is black
  bool get lighStatusBar;

  String get route;

  DashboardState(this.index);
}

class DashboardHome extends DashboardState {
  DashboardHome() : super(DashboardPage.home.index);

  @override
  bool get lighStatusBar => false;

  @override
  String get route => 'home';
}

class DashboardProduct extends DashboardState {
  DashboardProduct() : super(DashboardPage.product.index);

  @override
  bool get lighStatusBar => false;

  @override
  String get route => 'cosmetic_list';
}

class DashboardAppointment extends DashboardState {
  DashboardAppointment() : super(DashboardPage.appointment.index);

  @override
  bool get lighStatusBar => false;

  @override
  String get route => 'appointment_list';
}

class DashboardPromotion extends DashboardState {
  DashboardPromotion() : super(DashboardPage.promotion.index);
  @override
  bool get lighStatusBar => false;

  @override
  String get route => 'promo_list';
}

class DashboardAccount extends DashboardState {
  DashboardAccount() : super(DashboardPage.account.index);
  @override
  bool get lighStatusBar => false;

  @override
  String get route => 'account';
}
