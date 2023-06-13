import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_page_bloc.dart';
import 'views/home_page_screen.dart';

class HomePageRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        '': (context) {
          return BlocProvider(
            create: (context) => HomePageBloc(),
            child: const HomePageScreen(),
          );
        },
      };
}
