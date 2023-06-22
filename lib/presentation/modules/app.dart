import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shake/shake.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:vibration/vibration.dart';

import '../../common/components/navigation/navigation_observer.dart';
import '../../common/config.dart';
import '../../common/constants/locale/app_locale.dart';
import '../../common/utils/log_utils.dart';
import '../../data/data_source/local/local_data_manager.dart';
import '../../data/data_source/remote/app_api_service.dart';
import '../../di/di.dart';
import '../../domain/entities/app_data.dart';
import '../common_bloc/app_data_bloc.dart';
import '../common_bloc/cubit/location_cubit.dart';
import '../common_widget/text_scale_fixed.dart';
import '../extentions/extention.dart';
import '../route/route.dart';
import '../route/route_list.dart';
import '../theme/theme_color.dart';
import '../theme/theme_data.dart';
import 'welcome/splash/bloc/splash_bloc.dart';
import 'welcome/splash/splash_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<App> {
  late StreamSubscription _socketSubscription;
  late Socket _socket;

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

    _socketSubscription =
        injector.get<AppApiService>().localDataManager.onAuthChanged.listen(
              _setUpSocket,
            );
  }

  late AppLocalizations trans;

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

  void _setUpSocket(SocketArgs args) {
    final context = navigatorKey.currentState!.context,
        trans = translate(context);

    _socket = io(
      'ws://protee-be.herokuapp.com/',
      OptionBuilder().setTransports(['websocket']).setQuery({
        'accessToken': args.accessToken,
        'familyId': args.familyId,
      }).build(),
    );

    _socket
      ..on(
        'join',
        (data) {
          LogUtils.d('setUpSocket $data');
        },
      )
      ..on('notification', (data) async {
        if (await Vibration.hasCustomVibrationsSupport() ?? false) {
          await Vibration.vibrate(duration: 1000);
        } else {
          await Vibration.vibrate();
          await Future.delayed(const Duration(milliseconds: 500));
          await Vibration.vibrate();
        }
        await showModal(
          context,
          Column(
            children: [
              Text(
                trans.yourChildEnterWarningLocation,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: themeColor.red,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: const [],
              ),
            ],
          ),
          title: trans.warning,
        ).then((value) async {
          await Vibration.cancel();
        });
      });
  }

  @override
  void dispose() {
    _socket.dispose();
    _socketSubscription.cancel();
    super.dispose();
  }
}
