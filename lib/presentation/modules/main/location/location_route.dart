import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/location_bloc.dart';
import 'views/location_screen.dart';

class LocationRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        //TODO: Update route name
        '': (context) {
          return BlocProvider(
            create: (context) => LocationBloc(),
            child: const LocationScreen(),
          );
        },
      };
}
