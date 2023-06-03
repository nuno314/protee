part of 'family_profile_screen.dart';

extension FamilyProfileAction on _FamilyProfileScreenState {
  void _blocListener(BuildContext context, FamilyProfileState state) {
    _controller.refreshCompleted();
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

  void _onTapRequests() {}

  void _onTapSettings() {
    Navigator.pushNamed(
      context,
      RouteList.familySettings,
      arguments: bloc.state.family,
    );
  }

  Future<void> removeMember(CompletionHandler handler, User member) async {
    await showNoticeConfirmDialog(
      context: context,
      message: trans.confirmRemoveMember,
      title: trans.inform,
      onConfirmed: () async {
        await handler(true);
        bloc.add(
          RemoveMemberEvent(member),
        );
      },
    );
  }
}
