part of 'profile_screen.dart';

extension ProfileAction on _ProfileScreenState {
  void _blocListener(BuildContext context, ProfileState state) {
    hideLoading();

    if (state is ProfileUpdated) {
      showNoticeDialog(
        context: context,
        message: trans.updateProfileSuccessfully,
      ).then((value) {
        Navigator.pop(context);
      });
    }
  }

  void _showBirthdayPicker() {
    showCupertinoCustomDatePicker(
      context,
      _pickBirthday ?? DateTime.now(),
      (DateTime? newDate) {
        _pickBirthday = newDate;
        _dobController.text = newDate?.toddmmyyyy() ?? '';
      },
      maxDate: DateTime.now(),
    );
  }

  void _onBack() {
    Navigator.pop(context);
  }

  void _onTapUpdate() {
    if (_nameController.text.isNullOrEmpty) {
      _nameController.setError(trans.pleaseEnterFullName);
      return;
    }
    showLoading();
    bloc.add(UpdateProfileEvent(_user!));
  }
}
