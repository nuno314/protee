import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/notification_bloc.dart';
import 'views/notification_screen.dart';

class NotificationRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        '': (context) {
          return BlocProvider(
            create: (context) => NotificationBloc(),
            child: const NotificationScreen(),
          );
        },
      };
}
