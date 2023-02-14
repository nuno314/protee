import '../../../../common/definations.dart';

const detailModuleRepository = '''import 'package:core/data/data.dart';

part '${moduleNameKey}_repository.impl.dart';

abstract class ${classNameKey}Repository {
  Future<$modelNameKey?> get$classNameKey(String id);
}''';
