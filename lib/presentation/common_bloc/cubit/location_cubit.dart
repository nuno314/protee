import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../common/services/location_service.dart';
import '../../../common/services/permission_service.dart';
import '../../../data/models/address.dart';
import '../../../di/di.dart';
import '../../../domain/entities/place.entity.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  late final _locationService = injector.get<LocationService>();

  StreamSubscription? _serviceStatusStream;

  LocationCubit() : super(LocationInitial()) {
    _serviceStatusStream = _locationService.serviceStatusStream.listen((event) {
      if (event == ServiceStatus.enabled) {
        refreshLocation();
      }
    });
  }

  void getLastKnownLocation() {
    refreshLocation();
  }

  Future<void> refreshLocation({Address? address}) async {
    final location = await _locationService.getLastKnownLocation();
    final _address = address;
    // if (location != null) {
    //   _address = await _locationService.getAddressFromLocation(location);
    // }

    if (location == null && _address == null) {
      return;
    }

    emit(
      LocationInitial(
        currentPlace: Place(
          address: _address,
          location: location,
        ),
      ),
    );
  }

  bool get isValidPlace {
    return state.currentPlace?.isValid == true;
  }

  @override
  Future<void> close() {
    _serviceStatusStream?.cancel();
    return super.close();
  }
}
