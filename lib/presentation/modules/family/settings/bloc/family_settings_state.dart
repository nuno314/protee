part of 'family_settings_bloc.dart';

class _ViewModel {
  const _ViewModel();

  _ViewModel copyWith() {
    return const _ViewModel();
  }
}

abstract class FamilySettingsState {
  final _ViewModel viewModel;

  FamilySettingsState(this.viewModel);

  T copyWith<T extends FamilySettingsState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == FamilySettingsState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class FamilySettingsInitial extends FamilySettingsState {
  FamilySettingsInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  FamilySettingsInitial: (viewModel) => FamilySettingsInitial(
        viewModel: viewModel,
      ),
};