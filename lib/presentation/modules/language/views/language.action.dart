part of 'language_screen.dart';

extension LanguageAction on _LanguageScreenState {
  void _blocListener(BuildContext context, LanguageState state) {
    if (state is LanguageUpdated) {
      hideLoading();
      showNoticeDialog(context: context, message: trans.changeLanguage).then(
        (value) => Navigator.pop(context),
      );
    }
  }
}
