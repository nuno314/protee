part of 'family_settings_screen.dart';

extension FamilySettingsAction on _FamilySettingsScreenState {
  void _blocListener(BuildContext context, FamilySettingsState state) {}

  void _onTapLeaveFamily() {
    showNoticeConfirmDialog(
      context: context,
      message: trans.confirmLeaveFamily,
      title: trans.inform,
      onConfirmed: () {
        Navigator.pop(context, true);
      },
    );
  }
}
