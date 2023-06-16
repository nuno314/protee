import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils/data_checker.dart';
import '../../../data/models/user.dart';
import '../../route/route_list.dart';
import 'message.dart';

class MessageRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.messenger: (context) {
          final user = asOrNull<User>(settings.arguments);
          return BlocProvider(
            create: (context) => MessageBloc(user!),
            child: const MessageScreen(),
          );
        },
        RouteList.messengerDetail: (context) {
          return BlocProvider(
            create: (context) => MessageDetailBloc(),
            child: const MessageDetailScreen(),
          );
        },
      };
}
