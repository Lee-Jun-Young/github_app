import 'package:flutter/material.dart';

class CustomThemeData {
  static final ThemeData light = ThemeData(
    textTheme: customTextTheme.copyWith(
        titleLarge: customTextTheme.titleLarge?.copyWith(color: Colors.black),
        bodyMedium: customTextTheme.bodyMedium?.copyWith(color: Colors.black),
        bodySmall: customTextTheme.bodySmall?.copyWith(color: Colors.black)),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.deepOrange,
      titleTextStyle: customTextTheme.titleLarge?.copyWith(color: Colors.black),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.black,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.deepOrange,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.deepOrange,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.black),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 4)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange, width: 4)),
    ),
  );
  static final ThemeData dark = ThemeData(
    textTheme: customTextTheme.copyWith(
        titleLarge:
            customTextTheme.titleLarge?.copyWith(color: Colors.deepOrange),
        bodyMedium:
            customTextTheme.bodyMedium?.copyWith(color: Colors.deepOrange),
        bodySmall:
            customTextTheme.bodySmall?.copyWith(color: Colors.deepOrange)),
    scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 1),
    appBarTheme: AppBarTheme(
        backgroundColor: const Color.fromRGBO(51, 51, 51, 1),
        titleTextStyle:
            customTextTheme.titleLarge?.copyWith(color: Colors.deepOrange),
        iconTheme: const IconThemeData(color: Colors.deepOrange)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromRGBO(41, 41, 41, 1),
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.white,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.white,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.deepOrange),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange, width: 4)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange, width: 4)),
    ),
  );

  static const TextTheme customTextTheme = TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
      bodyMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      bodySmall: TextStyle(fontWeight: FontWeight.w400, fontSize: 14));
}
