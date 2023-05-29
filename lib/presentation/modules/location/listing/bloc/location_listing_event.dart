part of 'location_listing_bloc.dart';

abstract class LocationListingEvent {}

class GetLocationsEvent extends LocationListingEvent {}

class LoadMoreLocationsEvent extends LocationListingEvent {}