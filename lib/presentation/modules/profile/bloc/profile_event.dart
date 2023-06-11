part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final User user;
  final File? avatar;

  UpdateProfileEvent({
    required this.user,
    this.avatar,
  });
}
