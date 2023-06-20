// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'location_tracking_bloc.dart';

class _ViewModel {
  final User? user;
  final List<UserLocation> warningPlaces;
  final List<UserLocation> places;
  final List<List<LatLng>> routes;
  final LatLng? latLng;
  final List<User> children;
  final List<ChildLastLocation?> lastLocations;

  const _ViewModel({
    this.user,
    this.warningPlaces = const [],
    this.places = const [],
    this.routes = const [],
    this.latLng,
    this.children = const [],
    this.lastLocations = const [],
  });

  _ViewModel copyWith({
    User? user,
    List<UserLocation>? warningPlaces,
    List<UserLocation>? places,
    List<List<LatLng>>? routes,
    LatLng? latLng,
    List<User>? children,
    List<ChildLastLocation?>? lastLocations,
  }) {
    return _ViewModel(
      user: user ?? this.user,
      warningPlaces: warningPlaces ?? this.warningPlaces,
      places: places ?? this.places,
      routes: routes ?? this.routes,
      latLng: latLng ?? this.latLng,
      children: children ?? this.children,
      lastLocations: lastLocations ?? this.lastLocations,
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

  User? get user => viewModel.user;
  List<UserLocation> get places => viewModel.places;
  List<UserLocation> get warningPlaces => viewModel.warningPlaces;
  LatLng? get latLng => viewModel.latLng;
  List<List<LatLng>> get routes => viewModel.routes;
  List<User> get children => viewModel.children;
  List<ChildLastLocation?> get lastLocations => viewModel.lastLocations;
  bool get isParent => viewModel.user?.isParent ?? false;
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

class GetRouteState extends LocationTrackingState {
  GetRouteState({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class ChildrenInitialState extends LocationTrackingState {
  ChildrenInitialState({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class ChildrenLastLocationState extends LocationTrackingState {
  ChildrenLastLocationState({
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
  GetRouteState: (viewModel) => GetRouteState(
        viewModel: viewModel,
      ),
  ChildrenInitialState: (viewModel) => ChildrenInitialState(
        viewModel: viewModel,
      ),
  ChildrenLastLocationState: (viewModel) => ChildrenLastLocationState(
        viewModel: viewModel,
      ),
};
