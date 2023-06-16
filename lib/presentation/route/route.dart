import 'package:flutter/cupertino.dart';

import '../common_widget/text_scale_fixed.dart';
import '../modules/authentication/authentication_route.dart';
import '../modules/family/family_route.dart';
import '../modules/language/language_route.dart';
import '../modules/location/location_route.dart';
import '../modules/log_viewer/log_viewer_route.dart';
import '../modules/main/main_route.dart';
import '../modules/message/message_route.dart';
import '../modules/profile/profile_route.dart';
import '../modules/webview/webview_route.dart';
import '../modules/welcome/welcome_route.dart';

class RouteGenerator {
  static Map<String, WidgetBuilder> _getAll(RouteSettings settings) => {
        ...WelcomeRoute.getAll(settings),
        ...LogViewerRoute.getAll(settings),
        ...WebviewRoute.getAll(settings),
        ...MainRoute.getAll(settings),
        ...AuthenticationRoute.getAll(settings),
        ...FamilyRoute.getAll(settings),
        ...LocationRoute.getAll(settings),
        ...ProfileRoute.getAll(settings),
        ...LanguageRoute.getAll(settings),
        ...MessageRoute.getAll(settings),
      };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final _builder = _getAll(settings)[settings.name!];

    return buildRoute(
      _builder ?? (context) => const SizedBox(),
      settings: settings,
    );
  }
}

Route buildRoute<T>(WidgetBuilder builder, {RouteSettings? settings}) {
  return CupertinoPageRoute<T>(
    builder: (context) => TextScaleFixed(
      child: builder(context),
    ),
    settings: settings,
  );
}
