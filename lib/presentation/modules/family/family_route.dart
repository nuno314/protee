import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          return BlocProvider(
            create: (context) => FamilyProfileBloc(),
            child: const FamilyProfileScreen(),
          );
        },
      };
}
