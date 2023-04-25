part of 'sign_in_screen.dart';

extension SignInAction on _SignInScreenState {
  void _blocListener(BuildContext context, SignInState state) {
    hideLoading();
    if (state is LoginSuccess) {
      gotoDashboardOrCallbackSuccess();
    }
  }

  Future<void> onLoginWithGoogle() async {
    showLoading();
    bloc.add(GoogleSignInEvent());
  }

  Future<void> onLoginWithFacebook() async {
    await FacebookAuth.instance.login().then(
          (value) => print(
            value.accessToken?.token,
          ),
        );
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
