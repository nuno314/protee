import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../route/route_list.dart';
import 'bloc/search_direction_bloc.dart';
import 'views/search_direction_screen.dart';

class SearchDirectionRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.searchRoute: (context) {
          return BlocProvider(
            create: (context) => SearchDirectionBloc(),
            child: const SearchDirectionScreen(),
          );
        },
      };
}
