part of 'search_direction_bloc.dart';

class _ViewModel {
  final List<PlacePrediction> predictions;
  final List<GoogleMapPlace> places;
  const _ViewModel({
    this.places = const [],
    this.predictions = const [],
  });

  _ViewModel copyWith({
    List<PlacePrediction>? predictions,
    List<GoogleMapPlace>? places,
  }) {
    return _ViewModel(
      places: places ?? this.places,
      predictions: predictions ?? this.predictions,
    );
  }
}

abstract class SearchDirectionState {
  final _ViewModel viewModel;

  SearchDirectionState(this.viewModel);

  T copyWith<T extends SearchDirectionState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == SearchDirectionState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  List<PlacePrediction> get predictions => viewModel.predictions;
  List<GoogleMapPlace> get places => viewModel.places;
}

class SearchDirectionInitial extends SearchDirectionState {
  SearchDirectionInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  SearchDirectionInitial: (viewModel) => SearchDirectionInitial(
        viewModel: viewModel,
      ),
};
