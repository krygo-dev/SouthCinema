import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:south_cinema/core/theme/colors.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    fontFamily: 'DMSans',
    textTheme: _textTheme(),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: tertiaryColor,
      onBackground: onBackgroundColor,
    ),
    iconTheme: const IconThemeData(color: primaryColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: backgroundColor,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    ),
  );
}

TextTheme _textTheme() {
  return const TextTheme(
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: primaryColor,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: secondaryColor,
    ),
    labelSmall: TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.w400,
      color: primaryColor,
    ),
    bodySmall: TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.w400,
      color: tertiaryColor,
    ),
  );
}
