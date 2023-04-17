part of 'sign_in_screen.dart';

extension SignInAction on _SignInScreenState {
  void _blocListener(BuildContext context, SignInState state) {}

  Future<void> onLoginWithGoogle() async {
    try {
      await _googleSignIn.signIn().then((value) {
        print(value);
        hideLoading();
      });
    } catch (error) {
      print(error);
    }
  }
}
