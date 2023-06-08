part of 'add_location_bloc.dart';

class _ViewModel {
  final List<PlacePrediction> predictions;
  final GoogleMapPlace? place;
  final List<GoogleMapPlace> places;
  const _ViewModel({
    this.predictions = const [],
    this.place,
    this.places = const [],
  });

  _ViewModel copyWith({
    List<PlacePrediction>? predictions,
    GoogleMapPlace? place,
    List<GoogleMapPlace>? places,
  }) {
    return _ViewModel(
      predictions: predictions ?? this.predictions,
      places: places ?? this.places,
      place: place ?? this.place,
    );
  }
}

abstract class AddLocationState {
  final _ViewModel viewModel;

  AddLocationState(this.viewModel);

  T copyWith<T extends AddLocationState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == AddLocationState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  List<PlacePrediction> get predictions => viewModel.predictions;

  List<GoogleMapPlace> get places => viewModel.places;

  GoogleMapPlace? get place => viewModel.place;
  Location? get location => place?.geometry?.location;
  String? get placeId => place?.placeId;
}

class AddLocationInitial extends AddLocationState {
  AddLocationInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class LocationChangedState extends AddLocationState {
  LocationChangedState({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class AddLocationSuccessfullyState extends AddLocationState {
  AddLocationSuccessfullyState({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  AddLocationInitial: (viewModel) => AddLocationInitial(
        viewModel: viewModel,
      ),
  LocationChangedState: (viewModel) => LocationChangedState(
        viewModel: viewModel,
      ),
  AddLocationSuccessfullyState: (viewModel) => AddLocationSuccessfullyState(
        viewModel: viewModel,
      ),
};
