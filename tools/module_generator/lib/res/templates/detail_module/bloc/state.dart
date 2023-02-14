import '../../../../common/definations.dart';

const detailModuleState = '''part of '${moduleNameKey}_bloc.dart';

class _ViewModel {
  final $modelNameKey? data;

  const _ViewModel({
    this.data,
  });

  _ViewModel copyWith({
    $modelNameKey? data,
  }) {
    return _ViewModel(
      data: data ?? this.data,
    );
  }
}

abstract class ${classNameKey}State {
  final _ViewModel viewModel;

  ${classNameKey}State(this.viewModel);

  T copyWith<T extends ${classNameKey}State>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == ${classNameKey}State ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  $modelNameKey? get data => viewModel.data;
}

class ${classNameKey}Initial extends ${classNameKey}State {
  ${classNameKey}Initial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  ${classNameKey}Initial: (viewModel) => ${classNameKey}Initial(
        viewModel: viewModel,
      ),
};''';
