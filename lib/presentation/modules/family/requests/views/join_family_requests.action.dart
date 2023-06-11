part of 'join_family_requests_screen.dart';

extension JoinFamilyRequestsAction on _JoinFamilyRequestsScreenState {
  void _blocListener(BuildContext context, JoinFamilyRequestsState state) {
    hideLoading();
    _requests = state.requests;
  }

  void onRefresh() {
    bloc.add(GetJoinRequestsEvent());
  }

  Future<void> declineRequest(CompletionHandler handler, User member) async {
    await showNoticeConfirmDialog(
      context: context,
      message: trans.confirmRemoveJoinRequest,
      title: trans.inform,
      onConfirmed: () async {
        await handler(true);
        // bloc.add(
        //   // RemoveMemberEvent(member),
        // );
      },
    );
  }

  void _onTapApproveRequest(JoinFamilyRequest request) {
    showNoticeConfirmDialog(
      context: context,
      message: trans.confirmApproveRequest,
      title: trans.inform,
      onConfirmed: () {
        // bloc.add(ApproveRequestEvent(request));
        // bloc.add(
        //   // RemoveMemberEvent(member),
        // );
      },
    );
  }
}
