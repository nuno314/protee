import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/location.dart';
import '../../../../base/base.dart';
import '../interactor/location_listing_interactor.dart';
import '../repository/location_listing_repository.dart';

part 'location_listing_event.dart';
part 'location_listing_state.dart';

class LocationListingBloc
    extends AppBlocBase<LocationListingEvent, LocationListingState> {
  late final _interactor = LocationListingInteractorImpl(
    LocationListingRepositoryImpl(),
  );

  LocationListingBloc()
      : super(LocationListingInitial(viewModel: const _ViewModel())) {
    on<UpdateCurrentEvent>(_onUpdateCurrentEvent);
    on<GetLocationsEvent>(_onGetLocationsEvent);
    on<RemoveLocationEvent>(_onRemoveLocationEvent);
  }

  Future<void> _onGetLocationsEvent(
    GetLocationsEvent event,
    Emitter<LocationListingState> emit,
  ) async {
    final data = await _interactor.getData();

    if (state.currentLocation != null) {
      data.sort((a, b) {
        if (!a.isValid) {
          return -1;
        }
        if (!b.isValid) {
          return 1;
        }

        return a
            .distanceFrom(state.currentLocation!)!
            .compareTo(b.distanceFrom(state.currentLocation)!);
      });
    }

    emit(
      state.copyWith<LocationListingInitial>(
        viewModel: state.viewModel.copyWith(
          data: data,
        ),
      ),
    );
  }

  FutureOr<void> _onUpdateCurrentEvent(
    UpdateCurrentEvent event,
    Emitter<LocationListingState> emit,
  ) async {
    emit(
      state.copyWith<LocationUpdatedState>(
        viewModel: state.viewModel.copyWith(
          currentLocation: event.location,
        ),
      ),
    );
  }

  FutureOr<void> _onRemoveLocationEvent(
    RemoveLocationEvent event,
    Emitter<LocationListingState> emit,
  ) async {
    final res = await _interactor.removeLocation(event.location.id!);

    if (res == true) {
      emit(state.copyWith<RemoveLocationSuccessfully>());
    }
  }
}
