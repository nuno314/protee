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
    } else if (state is AdjustRoleState) {
      showNoticeDialog(context: context, message: trans.adjustSuccessfully);
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
    ).then((value) => _controller.requestRefresh());
  }

  void _onTapSettings() {
    Navigator.pushNamed(
      context,
      RouteList.familySettings,
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
        bloc.add(
          RemoveMemberEvent(member),
        );
        showLoading();
        await handler(true);
      },
    );
  }

  void _onTapAdjustRole(UserFamily member) {
    if (member.role == FamilyRole.parent) {
      showNoticeConfirmDialog(
        context: context,
        message: trans.downgradeToChildConfirm,
        title: trans.inform,
        onConfirmed: () {
          showLoading();
          updateParent(member.id!);
        },
      );
    } else if (member.role == FamilyRole.child) {
      showNoticeConfirmDialog(
        context: context,
        message: trans.upgradeToParentConfirm,
        title: trans.inform,
        onConfirmed: () {
          showLoading();
          updateChild(member.id!);
        },
      );
    }
  }

  void updateChild(String id) {
    bloc.add(UpdateDownToChildEvent(id));
  }

  void updateParent(String id) {
    bloc.add(UpdateUpToParentEvent(id));
  }
}
