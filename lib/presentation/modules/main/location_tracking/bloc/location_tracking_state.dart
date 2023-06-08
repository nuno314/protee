part of 'location_tracking_bloc.dart';

class _ViewModel {
  final bool? isChildrenMode;
  final List<UserLocation> warningPlaces;
  final LatLng? latLng;
  const _ViewModel({
    this.isChildrenMode,
    this.warningPlaces = const [],
    this.latLng,
  });

  _ViewModel copyWith({
    bool? isChildrenMode,
    List<UserLocation>? warningPlaces,
    LatLng? latLng,
  }) {
    return _ViewModel(
      isChildrenMode: isChildrenMode ?? this.isChildrenMode,
      warningPlaces: warningPlaces ?? this.warningPlaces,
      latLng: latLng ?? this.latLng,
    );
  }
}

abstract class LocationTrackingState {
  final _ViewModel viewModel;

  LocationTrackingState(this.viewModel);

  T copyWith<T extends LocationTrackingState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == LocationTrackingState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  bool get isChildrenMode => viewModel.isChildrenMode ?? true;
  List<UserLocation> get warningPlaces => viewModel.warningPlaces;
  LatLng? get latLng => viewModel.latLng;
}

class LocationTrackingInitial extends LocationTrackingState {
  LocationTrackingInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class CurrentLocationChangedState extends LocationTrackingState {
  CurrentLocationChangedState({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  LocationTrackingInitial: (viewModel) => LocationTrackingInitial(
        viewModel: viewModel,
      ),
  CurrentLocationChangedState: (viewModel) => CurrentLocationChangedState(
        viewModel: viewModel,
      ),
};
