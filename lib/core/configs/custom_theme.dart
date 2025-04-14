import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme {
  static final defaultTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: primaryColor,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      foregroundColor: Colors.black,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.black),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(ascentColor),
        foregroundColor: WidgetStateProperty.all(Colors.white),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      barrierColor: secondaryColor.withAlpha(100),
    ),
  );
  static const Color primaryColor = Color.fromRGBO(0, 48, 146, 1);
  static const Color secondaryColor = Color.fromRGBO(0, 135, 158, 1);
  static const Color ascentColor = Color.fromRGBO(255, 171, 91, 1);
  static const Color accentColor = Color.fromRGBO(255, 242, 219, 1);
  static const Color backgroundColor = Colors.white;
}
