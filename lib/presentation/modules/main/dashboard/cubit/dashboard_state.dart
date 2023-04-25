part of 'dashboard_cubit.dart';

abstract class DashboardState {
  final int index;

  String get route;

  DashboardState(this.index);
}

class DashboardHome extends DashboardState {
  DashboardHome() : super(DashboardPage.home.index);

  @override
  String get route => 'home';
}

class DashboardMessage extends DashboardState {
  DashboardMessage() : super(DashboardPage.message.index);

  @override
  String get route => 'message_list';
}

class DashboardLocation extends DashboardState {
  DashboardLocation() : super(DashboardPage.location.index);

  @override
  String get route => 'location';
}

class DashboardNotification extends DashboardState {
  DashboardNotification() : super(DashboardPage.notification.index);

  @override
  String get route => 'notification';
}

class DashboardAccount extends DashboardState {
  DashboardAccount() : super(DashboardPage.account.index);

  @override
  String get route => 'account';
}
