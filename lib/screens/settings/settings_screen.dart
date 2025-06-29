import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../language/language_provider.dart';
import '../../theme/theme_manager.dart';
import '../../services/auth_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: themeManager.isDarkMode,
            onChanged: (value) => themeManager.toggleTheme(),
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: Text(languageProvider.currentLanguageName),
            trailing: const Icon(Icons.language),
            onTap: () => _showLanguageDialog(context, languageProvider),
          ),
          const Divider(),
          ListTile(
            title: const Text('Subscription'),
            subtitle: const Text('View your plan and renew'),
            leading: const Icon(Icons.subscriptions),
            onTap: () {
              Navigator.pushNamed(context, '/payment');
            },
          ),
          ListTile(
            title: const Text('About'),
            subtitle: const Text('Homeonix version 1.0'),
            leading: const Icon(Icons.info_outline),
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
            onTap: () async {
              await authService.signOut();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, LanguageProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: const Text('English'),
              value: 'en',
              groupValue: provider.currentLanguage,
              onChanged: (value) {
                provider.setLanguage(value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: const Text('বাংলা'),
              value: 'bn',
              groupValue: provider.currentLanguage,
              onChanged: (value) {
                provider.setLanguage(value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}