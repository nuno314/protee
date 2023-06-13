part of 'join_family_requests_bloc.dart';

abstract class JoinFamilyRequestsEvent {}

class GetJoinRequestsEvent extends JoinFamilyRequestsEvent {}

class ApprovalRequestEvent extends JoinFamilyRequestsEvent {
  final String id;

  ApprovalRequestEvent(this.id);
}
