// File: lib/theme/dark_theme.dart
import 'package:flutter/material.dart';

/// Dark Theme configuration for Homeonix.
/// এই থিমটি স্বয়ংক্রিয়ভাবে অ্যাপের dark mode চালু হলে প্রয়োগ হয়।

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  scaffoldBackgroundColor: const Color(0xFF121212),
  primaryColor: const Color(0xFF1DB954),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'Montserrat',
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),

  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: 'Montserrat',
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Colors.white70,
      fontFamily: 'Lato',
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1E1E1E),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.white38),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.white24),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF1DB954)),
    ),
    hintStyle: const TextStyle(color: Colors.white54),
    labelStyle: const TextStyle(color: Colors.white70),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF1DB954),
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Nunito',
      ),
    ),
  ),

  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return const Color(0xFF1DB954);
      }
      return Colors.grey;
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return const Color(0xFF1DB954).withOpacity(0.5);
      }
      return Colors.grey.withOpacity(0.3);
    }),
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(const Color(0xFF1DB954)),
    checkColor: MaterialStateProperty.all(Colors.black),
  ),

  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Color(0xFF1DB954),
  ),

  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFF1E1E1E),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    contentTextStyle: TextStyle(
      fontSize: 16,
      color: Colors.white70,
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1E1E1E),
    selectedItemColor: Color(0xFF1DB954),
    unselectedItemColor: Colors.white54,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
);