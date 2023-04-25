import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/account_bloc.dart';
import 'views/account_screen.dart';

class AccountRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        //TODO: Update route name
        '': (context) {
          return BlocProvider(
            create: (context) => AccountBloc(),
            child: const AccountScreen(),
          );
        },
      };
}
