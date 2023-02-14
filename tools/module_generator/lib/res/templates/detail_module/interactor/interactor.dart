import '../../../../common/definations.dart';

const detailModuleInteractor = '''import 'package:core/core.dart';

import '../repository/${moduleNameKey}_repository.dart';

part '${moduleNameKey}_interactor.impl.dart';

abstract class ${classNameKey}Interactor {
  Future<$modelNameKey?> get$classNameKey(String id);
}
''';
