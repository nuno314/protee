import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../route/route_list.dart';
import 'authentication.dart';

class AuthenticationRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.signIn: (context) {
          return BlocProvider(
            create: (context) => SignInBloc(),
            child: const SignInScreen(),
          );
        },
      };
}
