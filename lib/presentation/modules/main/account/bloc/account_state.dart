part of 'account_bloc.dart';

class _ViewModel {
  const _ViewModel();

  _ViewModel copyWith() {
    return const _ViewModel();
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