part of 'family_profile_bloc.dart';

abstract class FamilyProfileEvent {}

class GetFamilyProfileEvent extends FamilyProfileEvent {}

class RemoveMemberEvent extends FamilyProfileEvent {
  final User member;

  RemoveMemberEvent(this.member);
}
