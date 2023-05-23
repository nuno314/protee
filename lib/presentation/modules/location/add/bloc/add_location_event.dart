part of 'add_location_bloc.dart';

abstract class AddLocationEvent {}

class SearchLocationEvent extends AddLocationEvent {
  final String input;

  SearchLocationEvent(this.input);
}
