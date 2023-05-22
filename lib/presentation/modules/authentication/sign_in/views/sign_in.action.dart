part of 'sign_in_screen.dart';

extension SignInAction on _SignInScreenState {
  Future<void> _blocListener(BuildContext context, SignInState state) async {
    hideLoading();
    if (state is LoginSuccess) {
      await showNoticeDialog(
        context: context,
        message: state.token!,
        titleBtn: 'Sao chép',
        onClose: () async {
          await Clipboard.setData(
            ClipboardData(text: state.token!),
          );
          showToast('Sao chép thành công');
        },
      );
      gotoDashboardOrCallbackSuccess();
    } else if (state is LoginFailed) {
      hideLoading();
      await showNoticeDialog(context: context, message: 'Đăng nhập thât bại');
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
