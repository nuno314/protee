import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../data/models/place_prediction.dart';
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
  }

  Future<void> _onSearchLocationEvent(
    SearchLocationEvent event,
    Emitter<AddLocationState> emit,
  ) async {
    final predictions = await _interactor.searchPlace(event.input);

    emit(
      state.copyWith<AddLocationInitial>(
        viewModel: state.viewModel.copyWith(
          predictions: predictions,
        ),
      ),
    );
  }
}
