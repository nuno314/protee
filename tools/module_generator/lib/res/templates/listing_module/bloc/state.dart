import '../../../../common/definations.dart';

const listingModuleState = '''part of '${moduleNameKey}_bloc.dart';

class _ViewModel {
  final List<$modelNameKey> data;
  final bool canLoadMore;

  const _ViewModel({
    this.canLoadMore = false,
    this.data = const [],
  });

  _ViewModel copyWith({
    List<$modelNameKey>? data,
    bool? canLoadMore,
  }) {
    return _ViewModel(
      data: data ?? this.data,
      canLoadMore: canLoadMore ?? this.canLoadMore,
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

  List<$modelNameKey> get data => viewModel.data;
  bool get canLoadMore => viewModel.canLoadMore;
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
