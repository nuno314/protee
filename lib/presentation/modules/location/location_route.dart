import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils/data_checker.dart';
import '../../route/route_list.dart';
import 'listing/views/location_history_filter_screen.dart';
import 'location.dart';

class LocationRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.addLocation: (context) {
          return BlocProvider(
            create: (context) => AddLocationBloc(),
            child: const AddLocationScreen(),
          );
        },
        RouteList.locationListing: (context) {
          final args = asOrNull<LocationListingArgs>(settings.arguments);
          return BlocProvider(
            create: (context) => LocationListingBloc(
              args ?? const LocationListingArgs(),
            ),
            child: const LocationListingScreen(),
          );
        },
        RouteList.locationFilter: (context) {
          return LocationHistoryFilterScreen(
            filter: asOrNull(settings.arguments),
          );
        },
      };
}
