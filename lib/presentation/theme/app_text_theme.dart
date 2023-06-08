import 'package:flutter/material.dart';

import 'theme_color.dart';

class AppTextTheme {
  TextTheme light() => TextTheme(
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryText,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryText,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryText,
        ),
        titleLarge: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: themeColor.subText,
        ),
        titleMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: themeColor.subText,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: themeColor.subText,
        ),
        bodyLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: themeColor.primaryText,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: themeColor.primaryText,
        ),
        bodySmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.normal,
          color: themeColor.subText,
        ),
        labelLarge: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );

  TextTheme dark() => TextTheme(
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryText,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryText,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryText,
        ),
        titleLarge: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: themeColor.subText,
        ),
        titleMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: themeColor.subText,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: themeColor.subText,
        ),
        bodyLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: themeColor.primaryText,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: themeColor.primaryText,
        ),
        bodySmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.normal,
          color: themeColor.subText,
        ),
        labelLarge: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
}

extension TextThemExt on TextTheme {
  TextStyle? get textInput => bodyLarge?.copyWith(
        fontWeight: FontWeight.w400,
      );
  TextStyle? get inputTitle => titleMedium?.copyWith(
        color: const Color(0xFF8D8D94),
        fontWeight: FontWeight.w600,
      );
  TextStyle? get inputRequired => titleLarge!.copyWith(
        color: Colors.red,
      );
  TextStyle? get inputHint => titleSmall;

  TextStyle? get inputError => titleMedium?.copyWith(
        color: Colors.red,
      );

  TextStyle? get textLinkStyle => titleSmall?.copyWith(
        decoration: TextDecoration.underline,
        color: themeColor.linkText,
        fontSize: 14,
      );
}
