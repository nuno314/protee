part of 'home_page_bloc.dart';

abstract class HomePageEvent {}

class UpdateAccountEvent extends HomePageEvent {
  final User? user;

  UpdateAccountEvent(this.user);
}

class InitHomePageEvent extends HomePageEvent {}

class GetFamilyStatisticEvent extends HomePageEvent {}

class GetFamilyMembersEvent extends HomePageEvent {}
