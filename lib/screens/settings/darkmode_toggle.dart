// File: lib/screens/settings/darkmode_toggle.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/themes/theme_manager.dart'; // যদি থিম ম্যানেজার core বা theme ফোল্ডারে থাকে

class DarkModeToggle extends StatelessWidget {
  const DarkModeToggle({Key? key}) : super(key: key);

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