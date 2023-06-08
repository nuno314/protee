import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../data/models/location.dart';
import '../../../../../data/models/place_prediction.dart';
import '../../../../../data/models/response.dart';
import '../../../../base/base.dart';
import '../interactor/add_location_interactor.dart';
import '../repository/add_location_repository.dart';

part 'add_location_event.dart';
part 'add_location_state.dart';

class AddLocationBloc extends AppBlocBase<AddLocationEvent, AddLocationState> {
  late final _interactor = AddLocationInteractorImpl(
    AddLocationRepositoryImpl(),
  );

  AddLocationBloc() : super(AddLocationInitial(viewModel: const _ViewModel())) {
    on<SearchLocationEvent>(_onSearchLocationEvent);
    on<GetLocationByPlaceIdEvent>(_onGetLocationByPlaceIdEvent);
    on<GetPLaceByLocation>(_onGetPLaceByLocation);
    on<AddUserLocationEvent>(_onAddUserLocationEvent);
    on<UpdatePlaceEvent>(_onUpdatePlaceEvent);
  }

  Future<void> _onSearchLocationEvent(
    SearchLocationEvent event,
    Emitter<AddLocationState> emit,
  ) async {
    final predictions = await _interactor.searchPlace(event.input);
    final places = await _interactor.findPlaceFromText(event.input);

    emit(
      state.copyWith<AddLocationInitial>(
        viewModel: state.viewModel.copyWith(
          places: places,
          predictions: predictions,
        ),
      ),
    );
  }

  FutureOr<void> _onGetLocationByPlaceIdEvent(
    GetLocationByPlaceIdEvent event,
    Emitter<AddLocationState> emit,
  ) async {
    final place = await _interactor.getLocationByPlaceId(event.place.placeId!);

    emit(
      state.copyWith<LocationChangedState>(
        viewModel: state.viewModel.copyWith(
          place: place,
        ),
      ),
    );
  }

  FutureOr<void> _onGetPLaceByLocation(
    GetPLaceByLocation event,
    Emitter<AddLocationState> emit,
  ) async {
    final place = await _interactor.getNearbyLocation(event.location);
    emit(
      state.copyWith<LocationChangedState>(
        viewModel: state.viewModel.copyWith(
          place: place,
        ),
      ),
    );
  }

  Future<void> _onAddUserLocationEvent(
    AddUserLocationEvent event,
    Emitter<AddLocationState> emit,
  ) async {
    final res = await _interactor.addLocation(
      event.name,
      event.description,
      event.location,
    );

    if (res == true) {
      emit(
        state.copyWith<AddLocationSuccessfullyState>(),
      );
    }
  }

  FutureOr<void> _onUpdatePlaceEvent(
    UpdatePlaceEvent event,
    Emitter<AddLocationState> emit,
  ) {
    emit(
      state.copyWith<LocationChangedState>(
        viewModel: state.viewModel.copyWith(
          place: event.place,
        ),
      ),
    );
  }
}
