part of 'home_page_bloc.dart';

abstract class HomePageEvent {}

class UpdateAccountEvent extends HomePageEvent {
  final User? user;

  UpdateAccountEvent(this.user);
}

class GetFamilyStatisticEvent extends HomePageEvent {}