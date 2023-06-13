part of 'profile_bloc.dart';

class _ViewModel {
  final UserFamily? user;
  const _ViewModel({
    this.user,
  });

  _ViewModel copyWith({UserFamily? user}) {
    return _ViewModel(user: user ?? this.user);
  }
}

abstract class ProfileState {
  final _ViewModel viewModel;

  ProfileState(this.viewModel);

  T copyWith<T extends ProfileState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == ProfileState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  UserFamily? get user => viewModel.user;
}

class ProfileInitial extends ProfileState {
  ProfileInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class ProfileUpdated extends ProfileState {
  ProfileUpdated({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  ProfileInitial: (viewModel) => ProfileInitial(
        viewModel: viewModel,
      ),
  ProfileUpdated: (viewModel) => ProfileUpdated(
        viewModel: viewModel,
      ),
};
