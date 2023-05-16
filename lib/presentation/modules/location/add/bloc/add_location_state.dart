part of 'add_location_bloc.dart';

class _ViewModel {
  const _ViewModel();

  _ViewModel copyWith() {
    return const _ViewModel();
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