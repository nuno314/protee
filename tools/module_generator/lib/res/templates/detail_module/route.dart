import '../../../common/definations.dart';

const detailModuleRoute = '''import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'bloc/${moduleNameKey}_bloc.dart';
import 'views/${moduleNameKey}_screen.dart';

class ${classNameKey}Route {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        //TODO: Update route name
        '': (context) {
          final args = asOrNull<${classNameKey}Args>(settings.arguments);
          return BlocProvider(
            create: (context) => ${classNameKey}Bloc(args?.initial),
            child: ${classNameKey}Screen(args: args),
          );
        },
      };
}
''';
