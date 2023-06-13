part of 'location_listing_bloc.dart';

class _ViewModel {
  final List<UserLocation> data;
  final Location? currentLocation;

  const _ViewModel({
    this.data = const [],
    this.currentLocation,
  });

  _ViewModel copyWith({
    List<UserLocation>? data,
    bool? canLoadMore,
    Location? currentLocation,
  }) {
    return _ViewModel(
      data: data ?? this.data,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }
}

abstract class LocationListingState {
  final _ViewModel viewModel;

  LocationListingState(this.viewModel);

  T copyWith<T extends LocationListingState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == LocationListingState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  List<UserLocation> get data => viewModel.data;
  Location? get currentLocation => viewModel.currentLocation;
}

class LocationListingInitial extends LocationListingState {
  LocationListingInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class LocationUpdatedState extends LocationListingState {
  LocationUpdatedState({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class RemoveLocationSuccessfully extends LocationListingState {
  RemoveLocationSuccessfully({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  LocationListingInitial: (viewModel) => LocationListingInitial(
        viewModel: viewModel,
      ),
  LocationUpdatedState: (viewModel) => LocationUpdatedState(
        viewModel: viewModel,
      ),
  RemoveLocationSuccessfully: (viewModel) => RemoveLocationSuccessfully(
        viewModel: viewModel,
      ),
};
