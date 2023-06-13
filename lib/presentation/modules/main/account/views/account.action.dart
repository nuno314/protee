part of 'account_screen.dart';

extension AccountAction on _AccountScreenState {
  void _blocListener(BuildContext context, AccountState state) {}

  void _onTapProfile() {
    Navigator.pushNamed(
      context,
      RouteList.profile,
      arguments: bloc.state.user,
    ).then((value) {
      if (value is User) {
        bloc.add(UpdateAccountEvent(value));
      }
    });
  }

  void _onTapChangeLanguage() {
    Navigator.pushNamed(context, RouteList.changeLanguage);
  }

  void _onTapLogOut() {
    showNoticeConfirmDialog(
      context: context,
      message: trans.confirmLogout,
      title: trans.inform,
      onConfirmed: () {
        doLogout().then((value) {
          hideLoading();
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteList.signIn,
            (_) => false,
          );
        });
      },
    );
  }
}
