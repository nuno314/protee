part of 'family_profile_bloc.dart';

class _ViewModel {
  const _ViewModel();

  _ViewModel copyWith() {
    return const _ViewModel();
  }
}

abstract class FamilyProfileState {
  final _ViewModel viewModel;

  FamilyProfileState(this.viewModel);

  T copyWith<T extends FamilyProfileState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == FamilyProfileState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class FamilyProfileInitial extends FamilyProfileState {
  FamilyProfileInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  FamilyProfileInitial: (viewModel) => FamilyProfileInitial(
        viewModel: viewModel,
      ),
};