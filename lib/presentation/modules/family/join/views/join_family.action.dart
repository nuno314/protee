part of 'join_family_screen.dart';

extension JoinFamilyAction on _JoinFamilyScreenState {
  void _blocListener(BuildContext context, JoinFamilyState state) {
    hideLoading();
    if (state is JoinFamilySuccessfullyState) {
      showNoticeDialog(context: context, message: trans.joinFamilySuccessfully)
          .then(
        (value) => Navigator.pop(context),
      );
    }
  }

  void _onTapJoinFamily() {
    if (_codeController.text.isNullOrEmpty) {
      _codeController.setError(trans.pleaseEnterInvitationCode);
      return;
    }

    showLoading();
    bloc.add(JoinFamilyByCodeEvent(_codeController.text));
  }
}
