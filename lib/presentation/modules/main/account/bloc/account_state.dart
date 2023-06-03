part of 'account_bloc.dart';

class _ViewModel {
  final User? user;
  const _ViewModel({
    this.user,
  });

  _ViewModel copyWith({User? user}) {
    return _ViewModel(user: user ?? this.user);
  }
}

abstract class AccountState {
  final _ViewModel viewModel;

  AccountState(this.viewModel);

  T copyWith<T extends AccountState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == AccountState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  User? get user => viewModel.user;
}

class AccountInitial extends AccountState {
  AccountInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  AccountInitial: (viewModel) => AccountInitial(
        viewModel: viewModel,
      ),
};
