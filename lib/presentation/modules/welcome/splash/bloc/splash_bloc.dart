import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info/device_info.dart';
import 'package:meta/meta.dart';
import 'package:package_info/package_info.dart';

import '../../../../../common/client_info.dart';
import '../../../../../common/services/auth_service.dart';
import '../../../../../di/di.dart';
import '../../../../base/base.dart';
import '../../../../route/route_list.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends AppBlocBase<SplashEvent, SplashState> {
  late final _authService = injector.get<AuthService>();

  SplashBloc() : super(SplashInitialState()) {
    on<SplashInitialEvent>(initial);
  }

  Future<void> initial(
    SplashInitialEvent event,
    Emitter<SplashState> emitter,
  ) async {
    await _configServices();
    // await _configRepo.getAppSetting();

    emitter(
      SplashFinishState(
        isLoggedIn ? RouteList.dashboard : RouteList.signIn,
      ),
    );
  }

  Future<void> _configServices() async {
    await getClientInfo();
    await _authService.init();
    if (_authService.isSignedIn) {
      await _authService.refreshToken();
    }
  }

  Future<void> getClientInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    final result = await Future.wait([
      if (Platform.isAndroid) deviceInfo.androidInfo,
      if (Platform.isIOS) deviceInfo.iosInfo,
      PackageInfo.fromPlatform()
    ]);

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
}
