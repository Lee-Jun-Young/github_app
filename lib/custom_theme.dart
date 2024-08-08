import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomThemeMode {
  static final CustomThemeMode instance = CustomThemeMode._internal();
  static ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);

  factory CustomThemeMode() => instance;

  late final SharedPreferences prefs;

  CustomThemeMode._internal();

  static void change(ThemeMode mode) {
    themeMode.value = mode;
    _saveThemeMode(mode);
  }

  static Future<void> _saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode.toString());
  }

  static Future<void> _loadThemeMode(String themeString) async {
    switch (themeString) {
      case 'ThemeMode.dark':
        themeMode.value = ThemeMode.dark;
        break;
      case 'ThemeMode.light':
      default:
        themeMode.value = ThemeMode.light;
        break;
    }
  }

  Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('themeMode') ?? 'ThemeMode.light';
    await _loadThemeMode(themeString);
  }
}
