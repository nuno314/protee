import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:injectable/injectable.dart';

import '../../di/di.dart';

ThemeColor get themeColor => injector.get<ThemeColor>();

@Singleton()
class ThemeColor {
  final Color white = Colors.white;
  final Color black = Colors.black;
  final Color primaryColor = const Color(0xFF62A6BB);
  final Color primaryColorLight = const Color(0xFF0CC0DF);
  final Color cardBackground = const Color(0xFFf7f8f8);
  final Color iconUnselected = Colors.grey;
  final Color lightGrey = const Color(0xFFbebebe);
  final Color greyDC = const Color(0xFFdcdcdc);
  final Color gray8C = const Color(0xFF8C8C8C);
  final Color scaffoldBackgroundColor = const Color(0xFFF1F3F7);

  final Color inactiveColor = const Color(0xFF111111);

  final Color titleMenu = Colors.grey;
  final Color primaryIcon = Colors.grey;
  final Color green = const Color(0xFF4d9e53);
  final Color red = const Color(0xFFfb4b53);
  final Color orange = const Color(0xFFff9b1a);
  final Color darkBlue = const Color(0xFF002d41);
  final Color color3b5998 = const Color(0xFF3b5998);

  //light
  final Color primaryText = Colors.black;
  final Color subText = const Color(0xFF767676);

  //dart
  final Color primaryDarkText = Colors.black;
  final Color subDarkText = Colors.grey;

  void setLightStatusBar() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  }

  void setDarkStatusBar() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  }
}
