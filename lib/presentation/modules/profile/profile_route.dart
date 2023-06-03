import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user.dart';
import '../../route/route_list.dart';
import 'bloc/profile_bloc.dart';
import 'views/profile_screen.dart';

class ProfileRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.profile: (context) {
          return BlocProvider(
            create: (context) => ProfileBloc(),
            child: ProfileScreen(
              user: settings.arguments as User?,
            ),
          );
        },
      };
}
