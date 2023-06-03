part of 'join_family_bloc.dart';

class _ViewModel {
  const _ViewModel();

  _ViewModel copyWith() {
    return const _ViewModel();
  }
}

abstract class JoinFamilyState {
  final _ViewModel viewModel;

  JoinFamilyState(this.viewModel);

  T copyWith<T extends JoinFamilyState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == JoinFamilyState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class JoinFamilyInitial extends JoinFamilyState {
  JoinFamilyInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class JoinFamilySuccessfullyState extends JoinFamilyState {
  JoinFamilySuccessfullyState({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  JoinFamilyInitial: (viewModel) => JoinFamilyInitial(
        viewModel: viewModel,
      ),
  JoinFamilySuccessfullyState: (viewModel) => JoinFamilySuccessfullyState(
        viewModel: viewModel,
      ),
};
