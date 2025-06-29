import 'package:flutter/material.dart';

/// CommonButton: Reusable button used across the app
///
/// Used in:
///   - lib/ui/home_page.dart
///   - lib/ui/remedy_result.dart
///   - lib/screens/auth/login_screen.dart
///   - lib/screens/settings/settings_screen.dart

class CommonButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final IconData? icon;
  final bool isFullWidth;

  const CommonButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF4CAF50), // Light Green (Homeonix Theme)
    this.textColor = Colors.white,
    this.borderRadius = 12.0,
    this.elevation = 2.0,
    this.icon,
    this.isFullWidth = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      elevation: elevation,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: icon != null
          ? ElevatedButton.icon(
              icon: Icon(icon, size: 20, color: textColor),
              label: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Nunito',
                ),
              ),
              onPressed: onPressed,
              style: buttonStyle,
            )
          : ElevatedButton(
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Nunito',
                ),
              ),
              onPressed: onPressed,
              style: buttonStyle,
            ),
    );
  }
}