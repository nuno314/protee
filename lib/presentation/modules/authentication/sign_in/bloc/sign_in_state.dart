part of 'sign_in_bloc.dart';

class _ViewModel {
  const _ViewModel();

  _ViewModel copyWith() {
    return const _ViewModel();
  }
}

abstract class SignInState {
  final _ViewModel viewModel;

  SignInState(this.viewModel);

  T copyWith<T extends SignInState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == SignInState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class SignInInitial extends SignInState {
  SignInInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  SignInInitial: (viewModel) => SignInInitial(
        viewModel: viewModel,
      ),
};