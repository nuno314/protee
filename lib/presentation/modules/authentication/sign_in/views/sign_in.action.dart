part of 'sign_in_screen.dart';

extension SignInAction on _SignInScreenState {
  Future<void> _blocListener(BuildContext context, SignInState state) async {
    hideLoading();
    if (state is LoginSuccess) {
      gotoDashboardOrCallbackSuccess();
    } else if (state is LoginFailed) {
      hideLoading();
      await showNoticeDialog(
        context: context,
        message: trans.loginFailed,
      );
    }
  }

  Future<void> onLoginWithGoogle() async {
    showLoading();
    bloc.add(GoogleSignInEvent());
  }

  Future<void> onLoginWithFacebook() async {
    showLoading();
    bloc.add(FacebookSignInEvent());
  }

  void gotoDashboardOrCallbackSuccess() {
    if (myNavigatorObserver.constaintRoute(RouteList.dashboard)) {
      Navigator.pop(context, true);
    } else {
      Navigator.of(context).pushReplacementNamed(
        RouteList.dashboard,
      );
    }
  }
}
