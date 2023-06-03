import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shake/shake.dart';

import '../../common/components/navigation/navigation_observer.dart';
import '../../common/config.dart';
import '../../common/constants/locale/app_locale.dart';
import '../../di/di.dart';
import '../../domain/entities/app_data.dart';
import '../common_bloc/app_data_bloc.dart';
import '../common_bloc/cubit/location_cubit.dart';
import '../common_widget/text_scale_fixed.dart';
import '../route/route.dart';
import '../route/route_list.dart';
import '../theme/theme_data.dart';
import 'welcome/splash/bloc/splash_bloc.dart';
import 'welcome/splash/splash_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<App> {
  @override
  void initState() {
    if (Config.instance.appConfig.isDevBuild) {
      ShakeDetector.autoStart(
        onPhoneShake: () {
          if (!myNavigatorObserver.constaintRoute(RouteList.logViewer)) {
            Navigator.pushNamed(
              navigatorKey.currentState!.context,
              RouteList.logViewer,
            );
          }
        },
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocationCubit()),
        BlocProvider(create: (_) => injector.get<AppDataBloc>()),
      ],
      child: BlocBuilder<AppDataBloc, AppData?>(
        builder: (context, appData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appData?.themeData ?? buildLightTheme().data,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocale.supportedLocales,
            locale: appData?.locale ?? AppLocale.defaultLocale,
            onGenerateRoute: RouteGenerator.generateRoute,
            home: BlocProvider(
              create: (_) => SplashBloc(),
              child: SplashScreen(),
            ),
            navigatorObservers: [myNavigatorObserver],
            navigatorKey: navigatorKey,
            builder: EasyLoading.init(
              builder: (_, child) {
                return TextScaleFixed(
                  child: child ?? const SizedBox(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
