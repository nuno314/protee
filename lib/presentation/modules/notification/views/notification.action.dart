part of 'notification_screen.dart';

extension NotificationAction on _NotificationScreenState {
  void _blocListener(BuildContext context, NotificationState state) {
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
    bloc.add(MarkAllNotificationEvent());
  }
}
