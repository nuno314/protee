import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../route/route_list.dart';
import 'bloc/language_bloc.dart';
import 'views/language_screen.dart';

class LanguageRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.changeLanguage: (context) {
          return BlocProvider(
            create: (context) => LanguageBloc(),
            child: const LanguageScreen(),
          );
        },
      };
}
