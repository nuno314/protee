import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:package_info/package_info.dart';

import '../../../../common/client_info.dart';
import '../../../../generated/assets.dart';
import '../../../base/base.dart';
import '../../../extentions/extention.dart';
import '../../../theme/theme_color.dart';
import 'bloc/splash_bloc.dart';

part 'splash_action.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends StateBase<SplashScreen> {
  @override
  void initState() {
    initial();
    super.initState();
  }

  @override
  SplashBloc get bloc => BlocProvider.of<SplashBloc>(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeColor.white,
      body: BlocListener<SplashBloc, SplashState>(
        listener: _blocListener,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.image.logo,
                    width: device.width - 36,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    translate(context).appName.toUpperCase(),
                    style: textTheme.bodyLarge!.copyWith(
                      color: themeColor.subText,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Text(
                'Powered By Flutter Base Tructure',
                style: textTheme.bodyMedium!.copyWith(
                  color: themeColor.subText,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
