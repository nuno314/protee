part of 'join_family_requests_bloc.dart';

abstract class JoinFamilyRequestsEvent {}

class GetJoinRequestsEvent extends JoinFamilyRequestsEvent {}

class ApproveRequestEvent extends JoinFamilyRequestsEvent {
  final String id;

  ApproveRequestEvent(this.id);
}

class RejectRequestEvent extends JoinFamilyRequestsEvent {
  final String id;

  RejectRequestEvent(this.id);
}
