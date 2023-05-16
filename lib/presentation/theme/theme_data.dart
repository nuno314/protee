import 'package:flutter/material.dart';

import 'app_text_theme.dart';
import 'theme_color.dart';

enum SupportedTheme { light, dark }

class AppTheme {
  final String name;
  final ThemeData data;

  const AppTheme(this.name, this.data);
}

InputDecorationTheme buildInputDecorationTheme() {
  final border = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
  );
  final focusedBorder = OutlineInputBorder(
    borderSide: BorderSide(color: themeColor.primaryColor, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
  );
  return InputDecorationTheme(
    border: border,
    enabledBorder: border,
    focusedBorder: focusedBorder,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 6,
    ),
  );
}

AppTheme buildLightTheme() {
  final textTheme = AppTextTheme().light();
  final theme = ThemeData(
    fontFamily: 'Nunito',
    brightness: Brightness.light,
    primaryColorLight: themeColor.primaryColorLight,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: themeColor.scaffoldBackgroundColor,
    cardColor: const Color(0xFF3e3c43),
    textTheme: textTheme,
    unselectedWidgetColor: Colors.grey,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: themeColor.primaryColor,
      selectionColor: themeColor.primaryColor,
      selectionHandleColor: themeColor.primaryColor,
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.normal,
      ),
      unselectedLabelColor: themeColor.subText,
      labelColor: themeColor.primaryColor,
    ),
    indicatorColor: themeColor.primaryColor,
    inputDecorationTheme: buildInputDecorationTheme(),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: themeColor.primaryColor,
      secondary: themeColor.primaryColorLight,
      background: Colors.white,
    ),
    platform: TargetPlatform.iOS,
  );
  return AppTheme(
    SupportedTheme.light.name,
    theme,
  );
}

AppTheme buildDarkTheme() {
  final textTheme = AppTextTheme().dark();

  final theme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Nunito',
    primaryColorLight: themeColor.primaryColorLight,
    primaryColor: ThemeData.dark().primaryColor,
    scaffoldBackgroundColor: ThemeData.dark().primaryColor,
    cardColor: const Color(0xFF3e3c43),
    textTheme: textTheme,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: themeColor.primaryColor,
      secondary: themeColor.primaryDarkText,
      brightness: Brightness.dark,
    ),
    unselectedWidgetColor: Colors.grey,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: themeColor.primaryColor,
      selectionColor: themeColor.primaryColor,
      selectionHandleColor: themeColor.primaryColor,
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: textTheme.bodyLarge,
      unselectedLabelStyle: textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.normal,
      ),
      unselectedLabelColor: themeColor.subText,
      labelColor: themeColor.primaryColor,
    ),
    indicatorColor: themeColor.primaryColor,
    inputDecorationTheme: buildInputDecorationTheme(),
    platform: TargetPlatform.iOS,
  );
  return AppTheme(
    'dark',
    theme,
  );
}
