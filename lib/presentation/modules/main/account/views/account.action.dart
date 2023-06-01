part of 'account_screen.dart';

extension AccountAction on _AccountScreenState {
  void _blocListener(BuildContext context, AccountState state) {}

  void _onTapProfile() {
    Navigator.pushNamed(context, RouteList.profile);
  }

  void _onTapSettings() {}
}
