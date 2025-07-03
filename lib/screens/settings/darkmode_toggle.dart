// File: lib/screens/settings/darkmode_toggle.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/themes/theme_manager.dart'; // Update path if different

class DarkModeToggle extends StatelessWidget {
  const DarkModeToggle({super.key}); // ✅ Improved by using super.key

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);

    return ListTile(
      leading: const Icon(Icons.dark_mode),
      title: const Text('Dark Mode'),
      trailing: Switch(
        value: themeNotifier.isDarkMode,
        onChanged: (_) {
          themeNotifier.toggleTheme();
        },
      ),
    );
  }
}
