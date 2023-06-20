part of 'location_tracking_bloc.dart';

abstract class LocationTrackingEvent {}

class GetPlacesEvent extends LocationTrackingEvent {}

class ChangeCurentLocation extends LocationTrackingEvent {
  final LatLng location;

  ChangeCurentLocation(this.location);
}

class GetWarningLocationNearbyEvent extends LocationTrackingEvent {}

class UpdateUserEvent extends LocationTrackingEvent {
  final User? user;

  UpdateUserEvent(this.user);
}

class GetDirectionsEvent extends LocationTrackingEvent {
  final String destination;

  GetDirectionsEvent({
    required this.destination,
  });
}

class GetChildrenLastLocationEvent extends LocationTrackingEvent {}

class GetChildrenEvent extends LocationTrackingEvent {}
