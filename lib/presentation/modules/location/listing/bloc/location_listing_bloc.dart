import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/location.dart';
import '../../../../base/base.dart';
import '../interactor/location_listing_interactor.dart';
import '../repository/location_listing_repository.dart';

part 'location_listing_event.dart';
part 'location_listing_state.dart';

class LocationListingBloc extends AppBlocBase<LocationListingEvent, LocationListingState> {
  late final _interactor = LocationListingInteractorImpl(
    LocationListingRepositoryImpl(),
  );
  
  LocationListingBloc() : super(LocationListingInitial(viewModel: const _ViewModel())) {
    on<GetLocationsEvent>(_onGetLocationsEvent);
    on<LoadMoreLocationsEvent>(_onLoadMoreLocationsEvent);
  }

  Future<void> _onGetLocationsEvent(
    GetLocationsEvent event,
    Emitter<LocationListingState> emit,
  ) async {
    final data = await _interactor.getData();
    emit(
      state.copyWith<LocationListingInitial>(
        viewModel: state.viewModel.copyWith(
          data: data,
          canLoadMore: _interactor.pagination.canNext,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreLocationsEvent(
    LoadMoreLocationsEvent event,
    Emitter<LocationListingState> emit,
  ) async {
    final moreData = await _interactor.loadMoreData();
    emit(
      state.copyWith<LocationListingInitial>(
        viewModel: state.viewModel.copyWith(
          data: [...state.viewModel.data, ...moreData],
          canLoadMore: _interactor.pagination.canNext,
        ),
      ),
    );
  }
}
