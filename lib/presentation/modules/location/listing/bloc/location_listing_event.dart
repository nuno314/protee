part of 'location_listing_bloc.dart';

abstract class LocationListingEvent {}

class UpdateCurrentEvent extends LocationListingEvent {
  final Location location;

  UpdateCurrentEvent(this.location);
}

class GetLocationsEvent extends LocationListingEvent {}

class LoadMoreLocationsEvent extends LocationListingEvent {}

class RemoveLocationEvent extends LocationListingEvent {
  final UserLocation location;

  RemoveLocationEvent(this.location);
}

class GetLocationHistoryEvent extends LocationListingEvent {}

class LoadMoreLocationHistoryEvent extends LocationListingEvent {}

class UpdateFilterEvent extends LocationListingEvent {
  final LocationFilter filter;

  UpdateFilterEvent(this.filter);
}

class GetChildrenEvent extends LocationListingEvent {}

