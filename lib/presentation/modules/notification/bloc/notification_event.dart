part of 'notification_bloc.dart';

abstract class NotificationEvent {}

class GetNotificationEvent extends NotificationEvent {}

class LoadMoreNotificationEvent extends NotificationEvent {}

class ReadNotificationEvent extends NotificationEvent {
  final String id;

  ReadNotificationEvent(this.id);
}

class MarkAllNotificationEvent extends NotificationEvent {}