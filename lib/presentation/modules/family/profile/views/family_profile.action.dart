part of 'family_profile_screen.dart';

extension FamilyProfileAction on _FamilyProfileScreenState {
  void _blocListener(BuildContext context, FamilyProfileState state) {
    hideLoading();
    _controller.refreshCompleted();

    if (state is RemoveMemberState) {
      showNoticeDialog(
        context: context,
        message: trans.removeMemberSuccessfully,
      );
    } else if (state is LeaveFamilyState) {
      showNoticeDialog(context: context, message: trans.leaveFamilySuccessfully)
          .then((value) {
        Navigator.pop(context);
      });
    }
  }

  void onRefresh() {
    bloc.add(GetFamilyProfileEvent());
  }

  void _onBack() {
    Navigator.pop(context);
  }

  void _onTapAddMember() {
    Navigator.pushNamed(context, RouteList.addMember);
  }

  void _onTapRequests() {
    Navigator.pushNamed(
      context,
      RouteList.joinFamilyRequests,
      arguments: bloc.state.requests,
    );
  }

  void _onTapSettings() {
    Navigator.pushNamed(
      context,
      RouteList.familySettings,
      arguments: bloc.state.family,
    ).then((value) {
      if (value is bool && value == true) {
        showLoading();
        bloc.add(LeaveFamilyEvent());
      }
    });
  }

  Future<void> removeMember(
    CompletionHandler handler,
    UserFamily member,
  ) async {
    await showNoticeConfirmDialog(
      context: context,
      message: trans.confirmRemoveMember,
      title: trans.inform,
      onConfirmed: () async {
        showLoading();
        await handler(true);
        bloc.add(
          RemoveMemberEvent(member),
        );
      },
    );
  }
}
