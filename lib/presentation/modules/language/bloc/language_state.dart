part of 'language_bloc.dart';

class _ViewModel {
  const _ViewModel();

  _ViewModel copyWith() {
    return const _ViewModel();
  }
}

abstract class LanguageState {
  final _ViewModel viewModel;

  LanguageState(this.viewModel);

  T copyWith<T extends LanguageState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == LanguageState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class LanguageInitial extends LanguageState {
  LanguageInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class LanguageUpdated extends LanguageState {
  LanguageUpdated({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  LanguageInitial: (viewModel) => LanguageInitial(
        viewModel: viewModel,
      ),
  LanguageUpdated: (viewModel) => LanguageUpdated(
        viewModel: viewModel,
      ),
};
