import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../route/route_list.dart';
import 'location.dart';

class LocationRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.addLocation: (context) {
          return BlocProvider(
            create: (context) => AddLocationBloc(),
            child: const AddLocationScreen(),
          );
        },
      };
}
