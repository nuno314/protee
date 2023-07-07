part of 'notification_screen.dart';

extension NotificationAction on _NotificationScreenState {
  void _blocListener(BuildContext context, NotificationState state) {
    hideLoading();
    _refreshController
      ..refreshCompleted()
      ..loadComplete();
  }

  void loadMore() {
    bloc.add(LoadMoreNotificationEvent());
  }

  void onRefresh() {
    bloc.add(GetNotificationEvent());
  }

  void _markAllNoti() {
    showLoading();
    bloc.add(MarkAllNotificationEvent());
  }
}
