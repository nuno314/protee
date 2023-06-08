import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/utils/extensions.dart';
import '../../../../../data/models/location.dart';
import '../../../../base/base.dart';
import '../interactor/location_tracking_interactor.dart';
import '../repository/location_tracking_repository.dart';

part 'location_tracking_event.dart';
part 'location_tracking_state.dart';

class LocationTrackingBloc
    extends AppBlocBase<LocationTrackingEvent, LocationTrackingState> {
  late final _interactor = LocationTrackingInteractorImpl(
    LocationTrackingRepositoryImpl(),
  );

  LocationTrackingBloc({bool? isChildrenMode})
      : super(
          LocationTrackingInitial(
            viewModel: _ViewModel(
              isChildrenMode: isChildrenMode,
            ),
          ),
        ) {
    on<ChangeCurentLocation>(_onChangeCurentLocation);
    on<GetWarningLocationNearbyEvent>(_onGetWarningLocationNearbyEvent);
  }

  Future<void> _onChangeCurentLocation(
    ChangeCurentLocation event,
    Emitter<LocationTrackingState> emit,
  ) async {
    print(event.location.distanceFrom(state.latLng));
    if (state.latLng == null ||
        event.location.distanceFrom(state.latLng!)! > 500) {
      emit(
        state.copyWith<CurrentLocationChangedState>(
          viewModel: state.viewModel.copyWith(latLng: event.location),
        ),
      );
    }
  }

  FutureOr<void> _onGetWarningLocationNearbyEvent(
    GetWarningLocationNearbyEvent event,
    Emitter<LocationTrackingState> emit,
  ) async {
    final places = await _interactor.getWarningLocationNearby(state.latLng!);

    emit(
      state.copyWith<LocationTrackingInitial>(
        viewModel: state.viewModel.copyWith(
          warningPlaces: places,
        ),
      ),
    );
  }
}
