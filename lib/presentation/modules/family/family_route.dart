import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils/data_checker.dart';
import '../../../data/models/family.dart';
import '../../../data/models/user.dart';
import '../../route/route_list.dart';
import 'family.dart';

class FamilyRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.addMember: (context) {
          return BlocProvider(
            create: (context) => AddMemberBloc(),
            child: const AddMemberScreen(),
          );
        },
        RouteList.joinFamily: (context) {
          return BlocProvider(
            create: (context) => JoinFamilyBloc(),
            child: const JoinFamilyScreen(),
          );
        },
        RouteList.familyProfile: (context) {
          final user = asOrNull<User?>(settings.arguments);
          return BlocProvider(
            create: (context) => FamilyProfileBloc(user),
            child: const FamilyProfileScreen(),
          );
        },
        RouteList.familySettings: (context) {
          return BlocProvider(
            create: (context) => FamilySettingsBloc(),
            child: const FamilySettingsScreen(),
          );
        },
        RouteList.joinFamilyRequests: (context) {
          final args = asOrNull<List<JoinFamilyRequest>>(settings.arguments);
          return BlocProvider(
            create: (context) => JoinFamilyRequestsBloc(),
            child: JoinFamilyRequestsScreen(
              requests: args,
            ),
          );
        },
      };
}
