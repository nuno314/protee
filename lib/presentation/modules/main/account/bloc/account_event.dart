part of 'account_bloc.dart';

abstract class AccountEvent {}

class UpdateAccountEvent extends AccountEvent {
  final User? user;

  UpdateAccountEvent(this.user);
}
