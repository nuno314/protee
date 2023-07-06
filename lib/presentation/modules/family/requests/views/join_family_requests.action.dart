part of 'join_family_requests_screen.dart';

extension JoinFamilyRequestsAction on _JoinFamilyRequestsScreenState {
  void _blocListener(BuildContext context, JoinFamilyRequestsState state) {
    hideLoading();
    _requests = state.requests;
    if (state is RequestApprovedState) {
      showNoticeDialog(
        context: context,
        message: trans.approveRequestSuccessfully,
      );
      _refreshController.requestRefresh();
    } else if (state is RequestRejectedState) {
      showNoticeDialog(
        context: context,
        message: trans.rejectRequestSuccessfully,
      );
      _refreshController.requestRefresh();
    }
  }

  void onRefresh() {
    bloc.add(GetJoinRequestsEvent());
  }

  Future<void> declineRequest(
    CompletionHandler handler,
    JoinFamilyRequest request,
  ) async {
    await showNoticeConfirmDialog(
      context: context,
      message: trans.confirmRemoveJoinRequest,
      title: trans.inform,
      onConfirmed: () async {
        await handler(true);
        bloc.add(
          RejectRequestEvent(request.id!),
        );
      },
    );
  }

  void _onTapApproveRequest(JoinFamilyRequest request) {
    showNoticeConfirmDialog(
      context: context,
      message: trans.confirmApproveRequest,
      title: trans.inform,
      onConfirmed: () {
        showLoading();
        bloc.add(ApproveRequestEvent(request.id!));
      },
    );
  }
}
