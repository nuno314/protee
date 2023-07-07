part of 'family_profile_bloc.dart';

abstract class FamilyProfileEvent {}

class GetFamilyProfileEvent extends FamilyProfileEvent {}

class RemoveMemberEvent extends FamilyProfileEvent {
  final UserFamily member;

  RemoveMemberEvent(this.member);
}

class LeaveFamilyEvent extends FamilyProfileEvent {}

class UpdateUpToParentEvent extends FamilyProfileEvent {
 final String id;

  UpdateUpToParentEvent(this.id);
}

class UpdateDownToChildEvent extends FamilyProfileEvent {
 final String id;

  UpdateDownToChildEvent(this.id);
}

class GetUserEvent extends FamilyProfileEvent {}
