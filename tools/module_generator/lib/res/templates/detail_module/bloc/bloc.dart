import '../../../../common/definations.dart';

const detailModuleBloc = '''import 'dart:async';

import 'package:core/core.dart';

import '${importPartKey}base/base.dart';
import '../interactor/${moduleNameKey}_interactor.dart';
import '../repository/${moduleNameKey}_repository.dart';

part '${moduleNameKey}_event.dart';
part '${moduleNameKey}_state.dart';

class ${classNameKey}Bloc extends AppBlocBase<${classNameKey}Event, ${classNameKey}State> {
  late final _interactor = ${classNameKey}InteractorImpl(
    ${classNameKey}RepositoryImpl(),
  );
  
  ${classNameKey}Bloc($modelNameKey? data) 
      : super(${classNameKey}Initial(viewModel: _ViewModel(data: data))) {
    on<Get${classNameKey}Event>(_onGet${classNameKey}Event);
  }

  Future<void> _onGet${classNameKey}Event(
    Get${classNameKey}Event event,
    Emitter<${classNameKey}State> emit,
  ) async {
    final data = await _interactor.get$classNameKey(event.id);
    emit(
      state.copyWith<${classNameKey}Initial>(
        viewModel: state.viewModel.copyWith(
          data: data,
        ),
      ),
    );
  }
}
''';
