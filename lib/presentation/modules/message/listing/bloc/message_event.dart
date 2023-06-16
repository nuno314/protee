part of 'message_bloc.dart';

abstract class MessageEvent {}

class GetMessagesEvent extends MessageEvent {}

class LoadMoreMessagesEvent extends MessageEvent {}

class SendMessageEvent extends MessageEvent {
  final String message;

  SendMessageEvent(this.message);
}
