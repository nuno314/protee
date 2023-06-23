import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../common/utils/data_checker.dart';
import '../../../../data/data_source/remote/app_api_service.dart';
import '../../../../data/models/place_prediction.dart';
import '../../../../data/models/response.dart';
import '../../../../di/di.dart';
import '../../../base/base.dart';

part 'search_direction_event.dart';
part 'search_direction_state.dart';

class SearchDirectionBloc
    extends AppBlocBase<SearchDirectionEvent, SearchDirectionState> {

  final _locationRepo = injector.get<AppApiService>().locationRepository;

  SearchDirectionBloc()
      : super(SearchDirectionInitial(viewModel: const _ViewModel())) {
    on<SearchSuggestionEvent>(_onSearchSuggestionEvent);
  }

  FutureOr<void> _onSearchSuggestionEvent(
    SearchSuggestionEvent event,
    Emitter<SearchDirectionState> emit,
  ) async {
    final predictions = await _locationRepo
        .getAutoComplete(
          input: event.value ?? '',
        )
        .then((value) => value.places ?? []);
    final places = await _locationRepo
        .findPlaceFromText(input: event.value ?? '')
        .then((value) => value.places ?? []);
    emit(
      state.copyWith<SearchDirectionInitial>(
        viewModel: state.viewModel.copyWith(
          places: asOrNull(places),
          predictions: asOrNull(predictions),
        ),
      ),
    );
  }
}
