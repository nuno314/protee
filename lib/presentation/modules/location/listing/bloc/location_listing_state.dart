part of 'location_listing_bloc.dart';

class _ViewModel {
  final List<UserLocation> data;
  final bool canLoadMore;

  const _ViewModel({
    this.canLoadMore = false,
    this.data = const [],
  });

  _ViewModel copyWith({
    List<UserLocation>? data,
    bool? canLoadMore,
  }) {
    return _ViewModel(
      data: data ?? this.data,
      canLoadMore: canLoadMore ?? this.canLoadMore,
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
  bool get canLoadMore => viewModel.canLoadMore;
}

class LocationListingInitial extends LocationListingState {
  LocationListingInitial({
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
};