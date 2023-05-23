part of 'add_location_bloc.dart';

class _ViewModel {
  final List<PlacePrediction> predictions;
  const _ViewModel({
    this.predictions = const [],
  });

  _ViewModel copyWith({
    List<PlacePrediction>? predictions,
  }) {
    return _ViewModel(
      predictions: predictions ?? this.predictions,
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

  List<String> get places => predictions
      .where((place) => place.description != null)
      .map((place) => place.description!)
      .toList();
}

class AddLocationInitial extends AddLocationState {
  AddLocationInitial({
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
};
