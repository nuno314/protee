part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final User user;

  UpdateProfileEvent(this.user);
}
