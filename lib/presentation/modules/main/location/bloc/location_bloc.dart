import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../base/base.dart';
import '../interactor/location_interactor.dart';
import '../repository/location_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends AppBlocBase<LocationEvent, LocationState> {
  late final _interactor = LocationInteractorImpl(
    LocationRepositoryImpl(),
  );
  
  LocationBloc() : super(LocationInitial(viewModel: const _ViewModel())) {
    on<LocationEvent>(_onLocationEvent);
  }

  Future<void> _onLocationEvent(
    LocationEvent event,
    Emitter<LocationState> emit,
  ) async {}
}