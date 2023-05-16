import 'dart:async';

import 'package:bloc/bloc.dart';

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
    on<AddLocationEvent>(_onAddLocationEvent);
  }

  Future<void> _onAddLocationEvent(
    AddLocationEvent event,
    Emitter<AddLocationState> emit,
  ) async {}
}