part of 'location_bloc.dart';

class _ViewModel {
  const _ViewModel();

  _ViewModel copyWith() {
    return const _ViewModel();
  }
}

abstract class LocationState {
  final _ViewModel viewModel;

  LocationState(this.viewModel);

  T copyWith<T extends LocationState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == LocationState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class LocationInitial extends LocationState {
  LocationInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  LocationInitial: (viewModel) => LocationInitial(
        viewModel: viewModel,
      ),
};