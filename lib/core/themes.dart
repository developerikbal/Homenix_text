// File: lib/core/themes.dart
// This file manages the global Light and Dark ThemeData used in Homeonix.
// Linked to: main.dart -> MaterialApp(theme: AppTheme.lightTheme, darkTheme: AppTheme.darkTheme)

import 'package:flutter/material.dart';

/// Define all color constants in one place for consistency
/// These are reused across themes, widgets, and UI elements
class AppColors {
  static const Color primary = Color(0xFF4CAF50); // Light Green (Homeonix Theme)
  static const Color secondary = Color(0xFF2E7D32); // Darker green
  static const Color accent = Color(0xFF00BCD4); // Cyan for highlights
  static const Color background = Color(0xFFF5F5F5); // Light grey
  static const Color surface = Colors.white;
  static const Color text = Colors.black87;
  static const Color textLight = Colors.white;
  static const Color error = Colors.redAccent;
}

/// Global Theme Configuration Class
class AppTheme {
  /// Light Theme Setup - Default for most users
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textLight,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textLight),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      background: AppColors.background,
      error: AppColors.error,
      onPrimary: AppColors.textLight,
      onSecondary: AppColors.textLight,
      onSurface: AppColors.text,
      onBackground: AppColors.text,
      onError: AppColors.textLight,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.text),
      bodyMedium: TextStyle(fontSize: 16, color: AppColors.text),
      labelLarge: TextStyle(fontSize: 14, color: AppColors.text),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    useMaterial3: true,
  );

  /// Dark Theme Setup - For dark mode users
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.textLight,
      elevation: 0,
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: Colors.grey[850]!,
      background: Colors.black,
      error: AppColors.error,
      onPrimary: AppColors.textLight,
      onSecondary: AppColors.textLight,
      onSurface: AppColors.textLight,
      onBackground: AppColors.textLight,
      onError: AppColors.textLight,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textLight),
      bodyMedium: TextStyle(fontSize: 16, color: AppColors.textLight),
      labelLarge: TextStyle(fontSize: 14, color: AppColors.textLight),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    useMaterial3: true,
  );
}