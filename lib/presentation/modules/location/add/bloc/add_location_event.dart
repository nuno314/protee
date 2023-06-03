part of 'add_location_bloc.dart';

abstract class AddLocationEvent {}

class SearchLocationEvent extends AddLocationEvent {
  final String input;

  SearchLocationEvent(this.input);
}

class GetLocationByPlaceIdEvent extends AddLocationEvent {
  final PlacePrediction place;

  GetLocationByPlaceIdEvent(this.place);
}

class GetPLaceByLocation extends AddLocationEvent {
  final Location location;

  GetPLaceByLocation(this.location);
}

class AddUserLocationEvent extends AddLocationEvent {
  final String name;
  final String description;
  final Location location;

  AddUserLocationEvent({
    required this.name,
    required this.description,
    required this.location,
  });
}
