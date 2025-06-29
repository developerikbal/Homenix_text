import 'package:flutter/material.dart';

/// Converts a hex string like "#4CAF50" into a Flutter [Color] object.
Color hexToColor(String hexCode) {
  final hex = hexCode.replaceAll('#', '');
  return Color(int.parse('FF$hex', radix: 16));
}

/// Generates a [MaterialColor] from a single [Color] to support full swatch shades.
/// Used in themes to define primarySwatch.
MaterialColor generateMaterialColor(Color color) {
  Map<int, Color> colorSwatch = {
    50:  _tintColor(color, 0.9),
    100: _tintColor(color, 0.8),
    200: _tintColor(color, 0.6),
    300: _tintColor(color, 0.4),
    400: _tintColor(color, 0.2),
    500: color,
    600: _shadeColor(color, 0.1),
    700: _shadeColor(color, 0.2),
    800: _shadeColor(color, 0.3),
    900: _shadeColor(color, 0.4),
  };
  return MaterialColor(color.value, colorSwatch);
}

/// Returns a lighter version of the provided [color] by applying the [factor].
Color _tintColor(Color color, double factor) {
  return Color.fromRGBO(
    color.red + ((255 - color.red) * factor).round(),
    color.green + ((255 - color.green) * factor).round(),
    color.blue + ((255 - color.blue) * factor).round(),
    1,
  );
}

/// Returns a darker version of the provided [color] by applying the [factor].
Color _shadeColor(Color color, double factor) {
  return Color.fromRGBO(
    (color.red * (1 - factor)).round(),
    (color.green * (1 - factor)).round(),
    (color.blue * (1 - factor)).round(),
    1,
  );
}

// Central color constants for the Homeonix app UI
const Color primaryColor = Color(0xFF4CAF50);    // Light Green
const Color secondaryColor = Color(0xFFFFFFFF);  // White
const Color dangerColor = Color(0xFFE53935);     // Red
const Color successColor = Color(0xFF43A047);    // Green
const Color warningColor = Color(0xFFFFA000);    // Amber