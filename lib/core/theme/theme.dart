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
      background: backgroundColor,
      onBackground: onBackgroundColor,
      onSurface: onSurfaceColor,
      error: errorColor,
    ),
    iconTheme: const IconThemeData(color: primaryColor, size: 20),
    appBarTheme: _appBarTheme(),
  );
}

TextTheme _textTheme() {
  return const TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'DMSans',
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontFamily: 'DMSans',
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: primaryColor,
    ),
    labelMedium: TextStyle(
      fontFamily: 'DMSans',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: secondaryColor,
    ),
    labelSmall: TextStyle(
      fontFamily: 'DMSans',
      fontSize: 8,
      fontWeight: FontWeight.w400,
      color: primaryColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'DMSans',
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: secondaryColor,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'DMSans',
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: primaryColor,
    ),
    bodySmall: TextStyle(
      fontFamily: 'DMSans',
      fontSize: 8,
      fontWeight: FontWeight.w400,
      color: tertiaryColor,
    ),
  );
}

AppBarTheme _appBarTheme() {
  return const AppBarTheme(
    backgroundColor: backgroundColor,
    iconTheme: IconThemeData(color: primaryColor, size: 23),
    elevation: 0,
    centerTitle: true,
    toolbarHeight: 80,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: backgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );
}