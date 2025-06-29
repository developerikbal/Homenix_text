import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ThemeManager ক্লাসটি থিম ম্যানেজ করে (Light, Dark, System)
/// এবং ব্যবহারকারীর পছন্দ লোকাল স্টোরেজে সংরক্ষণ করে।

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  /// বর্তমান থিম মোড রিটার্ন করে
  ThemeMode get themeMode => _themeMode;

  /// লোকাল স্টোরেজ থেকে থিম মোড লোড করে
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme_mode') ?? 'system';
    _themeMode = _getThemeModeFromString(theme);
    notifyListeners();
  }

  /// থিম মোড সেট করে এবং লোকাল স্টোরেজে সংরক্ষণ করে
  Future<void> setTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = mode;
    await prefs.setString('theme_mode', _getStringFromThemeMode(mode));
    notifyListeners();
  }

  /// থিম মোডের স্ট্রিং মান থেকে ThemeMode অবজেক্ট রিটার্ন করে
  ThemeMode _getThemeModeFromString(String theme) {
    switch (theme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  /// ThemeMode অবজেক্ট থেকে স্ট্রিং মান রিটার্ন করে
  String _getStringFromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
      default:
        return 'system';
    }
  }
}