part of 'join_family_bloc.dart';

abstract class JoinFamilyEvent {}

class JoinFamilyByCodeEvent extends JoinFamilyEvent {
  final String code;

  JoinFamilyByCodeEvent(this.code);
}
