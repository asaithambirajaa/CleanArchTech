import 'package:flutter/material.dart';

import '../core.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: SARPLColors.primaryColor,
      onPrimary: SARPLColors.onPrimaryColor,
      secondary: SARPLColors.secondaryColor,
      onSecondary: SARPLColors.onSecondaryColor,
      error: SARPLColors.secondaryColor,
      onError: SARPLColors.onSecondaryColor,
      surface: SARPLColors.primaryColor,
      onSurface: SARPLColors.black,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontFamily: SARPLFont.openSans,
        fontSize: UtilsMethods().getDeviceType() == DeviceType.phone ? 20 : 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontFamily: SARPLFont.openSans,
        fontSize: UtilsMethods().getDeviceType() == DeviceType.phone ? 18 : 22,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontFamily: SARPLFont.openSans,
        fontSize: UtilsMethods().getDeviceType() == DeviceType.phone ? 16 : 20,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      titleLarge: TextStyle(
        fontSize: UtilsMethods().getDeviceType() == DeviceType.phone ? 22 : 26,
        fontFamily: SARPLFont.openSans,
        height: 1.5,
        fontWeight: FontWeight.w700,
        color: SARPLColors.white,
      ),
      titleMedium: TextStyle(
        fontSize: UtilsMethods().getDeviceType() == DeviceType.phone ? 14 : 16,
        fontFamily: SARPLFont.openSans,
        height: 1.5,
        fontWeight: FontWeight.w700,
        color: SARPLColors.white,
      ),
      titleSmall: TextStyle(
        fontSize: UtilsMethods().getDeviceType() == DeviceType.phone ? 14 : 16,
        fontFamily: SARPLFont.openSans,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        height: 1.5,
      ),
      bodyLarge: TextStyle(
        fontFamily: SARPLFont.openSans,
        fontSize: UtilsMethods().getDeviceType() == DeviceType.phone ? 12 : 16,
        height: 1.5,
        fontWeight: FontWeight.w400,
        color: SARPLColors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: UtilsMethods().getDeviceType() == DeviceType.phone ? 15 : 18,
        fontFamily: SARPLFont.openSans,
        color: SARPLColors.primaryColor,
        height: 1.5,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(
        fontFamily: SARPLFont.openSans,
        fontSize: UtilsMethods().getDeviceType() == DeviceType.phone ? 12 : 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        height: 1.5,
      ),
      labelLarge: TextStyle(
        fontFamily: SARPLFont.openSans,
        fontSize: UtilsMethods().getDeviceType() == DeviceType.phone ? 16 : 20,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        height: 1.5,
      ),
      labelMedium: TextStyle(
        fontFamily: SARPLFont.openSans,
        fontSize: UtilsMethods().getDeviceType() == DeviceType.phone ? 14 : 18,
        fontWeight: FontWeight.w600,
        color: SARPLColors.black,
        height: 1.5,
      ),
      labelSmall: TextStyle(
        fontFamily: SARPLFont.openSans,
        fontSize: UtilsMethods().getDeviceType() == DeviceType.phone ? 12 : 16,
        fontWeight: FontWeight.w600,
        color: SARPLColors.black,
        height: 1.5,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0XFFEFF2F2),
    ),
  );
}
