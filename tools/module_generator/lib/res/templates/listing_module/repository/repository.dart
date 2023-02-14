import '../../../../common/definations.dart';

const listingModuleRepository = '''import 'package:core/data/data.dart';

part '${moduleNameKey}_repository.impl.dart';

abstract class ${classNameKey}Repository {
  Future<List<$modelNameKey>> getData(
    int offset,
    int limit,
  );
}''';
