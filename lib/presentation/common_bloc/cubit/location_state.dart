part of 'location_cubit.dart';

@immutable
abstract class LocationState {
  final Place? currentPlace;

  LocationState({this.currentPlace});

  String? get shortAddressDescription {
    final address = currentPlace?.address;

    return address?.shortAddressDescription;
  }
}

class LocationInitial extends LocationState {
  LocationInitial({
    Place? currentPlace,
  }) : super(currentPlace: currentPlace);
}
