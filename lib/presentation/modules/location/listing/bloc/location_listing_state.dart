// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'location_listing_bloc.dart';

class _ViewModel {
  final User? user;
  final List<UserLocation> data;
  final Location? currentLocation;
  final LocationFilter filter;
  final bool? canLoadMoreHistory;
  final List<LocationHistory> locationHistories;

  const _ViewModel({
    this.user,
    this.data = const [],
    this.currentLocation,
    this.filter = const LocationFilter(),
    this.canLoadMoreHistory,
    this.locationHistories = const [],
  });

  _ViewModel copyWith({
    User? user,
    List<UserLocation>? data,
    Location? currentLocation,
    LocationFilter? filter,
    bool? canLoadMoreHistory,
    List<LocationHistory>? locationHistories,
  }) {
    return _ViewModel(
      user: user ?? this.user,
      data: data ?? this.data,
      currentLocation: currentLocation ?? this.currentLocation,
      filter: filter ?? this.filter,
      canLoadMoreHistory: canLoadMoreHistory ?? this.canLoadMoreHistory,
      locationHistories: locationHistories ?? this.locationHistories,
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
  User? get user => viewModel.user;
  Location? get currentLocation => viewModel.currentLocation;
  LocationFilter get filter => viewModel.filter;
  bool get canLoadMoreHistory => viewModel.canLoadMoreHistory ?? false;
  bool get isParent => user?.isParent ?? false;
  List<LocationHistory> get locationHistories => viewModel.locationHistories;
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

class FilterUpdatedState extends LocationListingState {
  FilterUpdatedState({
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
  FilterUpdatedState: (viewModel) => FilterUpdatedState(
        viewModel: viewModel,
      ),
};
