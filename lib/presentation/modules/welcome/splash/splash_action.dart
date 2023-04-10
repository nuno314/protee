part of 'splash_screen.dart';

extension SplashAction on _SplashScreenState {
  void initial() {
    bloc.add(SplashInitialEvent());
  }

  void _blocListener(_, SplashState state) {
    if (state is SplashFinishState) {
      print('time to change screen');
      final nextScreen = state.nextScreen;

      _launchApp(nextScreen);
    }
  }

  Future<void> getClientInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    final result = await Future.wait([
      if (Platform.isAndroid) deviceInfo.androidInfo,
      if (Platform.isIOS) deviceInfo.iosInfo,
      PackageInfo.fromPlatform()
    ]).catchError((error, stackTrace) {});

    if (result.isNotEmpty) {
      if (Platform.isAndroid) {
        final androidInfo = result[0] as AndroidDeviceInfo;
        ClientInfo.model = '${androidInfo.manufacturer} ${androidInfo.model}';
        ClientInfo.osversion = androidInfo.version.release;
        ClientInfo.identifier = androidInfo.androidId;
      } else {
        final iosInfo = result[0] as IosDeviceInfo;
        ClientInfo.model = iosInfo.utsname.machine;
        ClientInfo.osversion = iosInfo.systemVersion;
        ClientInfo.identifier = iosInfo.identifierForVendor;
      }
      final info = result[1] as PackageInfo;
      ClientInfo.appVersionName = info.version;
      ClientInfo.appVersionCode = info.buildNumber;
    }
  }

  void _launchApp(String route) {
    removeNativeSplashScreen(shouldDelay: Platform.isAndroid);
    Navigator.pushNamedAndRemoveUntil(
      context,
      route,
      (route) => false,
    );
  }

  void removeNativeSplashScreen({bool shouldDelay = true}) {
    Future.delayed(
      Duration(
        milliseconds: shouldDelay ? 1000 : 50,
      ),
    ).then(
      (_) => FlutterNativeSplash.remove(),
    );
  }
}
