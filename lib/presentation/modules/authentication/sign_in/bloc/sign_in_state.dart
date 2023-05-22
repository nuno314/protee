part of 'sign_in_bloc.dart';

class _ViewModel {
  final String? token;
  const _ViewModel({
    this.token,
  });

  _ViewModel copyWith({String? token}) {
    return _ViewModel(token: token ?? this.token);
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

  String? get token => viewModel.token;
}

class SignInInitial extends SignInState {
  SignInInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class LoginSuccess extends SignInState {
  LoginSuccess({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class LoginFailed extends SignInState {
  LoginFailed({
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
  LoginSuccess: (viewModel) => LoginSuccess(
        viewModel: viewModel,
      ),
  LoginFailed: (viewModel) => LoginFailed(
        viewModel: viewModel,
      ),
};
