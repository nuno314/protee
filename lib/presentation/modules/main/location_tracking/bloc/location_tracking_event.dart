part of 'location_tracking_bloc.dart';

abstract class LocationTrackingEvent {}

class ChangeCurentLocation extends LocationTrackingEvent {
  final LatLng location;

  ChangeCurentLocation(this.location);
}

class GetWarningLocationNearbyEvent extends LocationTrackingEvent {}
