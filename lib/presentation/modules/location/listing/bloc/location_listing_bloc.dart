import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/location.dart';
import '../../../../../data/models/user.dart';
import '../../../../../di/di.dart';
import '../../../../../domain/entities/location_filter.entity.dart';
import '../../../../base/base.dart';
import '../interactor/location_listing_interactor.dart';
import '../repository/location_listing_repository.dart';

part 'location_listing_event.dart';
part 'location_listing_state.dart';

class LocationListingArgs {
  final List<User> children;
  final User? child;

  const LocationListingArgs({
    this.children = const [],
    this.child,
  });
}

class LocationListingBloc
    extends AppBlocBase<LocationListingEvent, LocationListingState> {
  late final _interactor = LocationListingInteractorImpl(
    LocationListingRepositoryImpl(),
  );

  LocationListingBloc(LocationListingArgs args)
      : super(
          LocationListingInitial(
            viewModel: _ViewModel(
              user: injector.get<AppApiService>().localDataManager.currentUser,
              filter: LocationFilter(
                child: args.children.firstOrNull,
                children: args.children,
              ),
            ),
          ),
        ) {
    on<UpdateCurrentEvent>(_onUpdateCurrentEvent);
    on<GetLocationsEvent>(_onGetLocationsEvent);
    on<RemoveLocationEvent>(_onRemoveLocationEvent);

    on<GetLocationHistoryEvent>(_onGetLocationHistoryEvent);
    on<LoadMoreLocationHistoryEvent>(_onLoadMoreLocationHistoryEvent);
    on<UpdateFilterEvent>(_onUpdateFilterEvent);
  }

  Future<void> _onGetLocationsEvent(
    GetLocationsEvent event,
    Emitter<LocationListingState> emit,
  ) async {
    final data = await _interactor.getSavedLocations();

    if (state.currentLocation != null) {
      data
        ..sort((a, b) {
          if (!a.isValid) {
            return -1;
          }
          if (!b.isValid) {
            return 1;
          }

          return a
              .distanceFrom(state.currentLocation!)!
              .compareTo(b.distanceFrom(state.currentLocation)!);
        })
        ..sort((a, b) {
          if (a.status == UserLocationStatus.published) {
            return 1;
          }
          return -1;
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

  Future<void> _onGetLocationHistoryEvent(
    GetLocationHistoryEvent event,
    Emitter<LocationListingState> emit,
  ) async {
    final data = await _interactor.getData(state.filter);

    emit(
      state.copyWith<LocationListingInitial>(
        viewModel: state.viewModel.copyWith(
          locationHistories: data,
          canLoadMoreHistory: _interactor.pagination.canNext,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreLocationHistoryEvent(
    LoadMoreLocationHistoryEvent event,
    Emitter<LocationListingState> emit,
  ) async {
    final moreData = await _interactor.loadMoreData(state.filter);
    emit(
      state.copyWith<LocationListingInitial>(
        viewModel: state.viewModel.copyWith(
          locationHistories: [
            ...state.viewModel.locationHistories,
            ...moreData
          ],
          canLoadMoreHistory: _interactor.pagination.canNext,
        ),
      ),
    );
  }

  FutureOr<void> _onUpdateFilterEvent(
    UpdateFilterEvent event,
    Emitter<LocationListingState> emit,
  ) async {
    emit(
      state.copyWith<FilterUpdatedState>(
        viewModel: state.viewModel.copyWith(filter: event.filter),
      ),
    );
  }
}
