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
      backgroundColor: Color.fromRGBO(55, 175, 225, 1),
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color.fromRGBO(76, 201, 254, 1),
      foregroundColor: Colors.white,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.black),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          Color.fromRGBO(245, 244, 179, 1),
        ),
        foregroundColor: WidgetStateProperty.all(Colors.black),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      barrierColor: secondaryColor.withAlpha(100),
    ),
  );
  static const Color primaryColor = Color.fromRGBO(55, 175, 225, 1);
  static const Color secondaryColor = Color.fromRGBO(76, 201, 254, 1);
  static const Color ascentColor = Color.fromRGBO(245, 244, 179, 1);
  static const Color accentColor = Color.fromRGBO(255, 254, 203, 1);
  static const Color backgroundColor = Colors.white;
}
