// File: lib/screens/welcome/language_selector.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../language/language_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final selectedLanguage = languageProvider.currentLocale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
        backgroundColor: Colors.green[700],
      ),
      body: ListView(
        children: [
          RadioListTile<String>(
            value: 'en',
            groupValue: selectedLanguage,
            title: const Text('English'),
            onChanged: (value) {
              if (value != null) {
                languageProvider.changeLanguage(const Locale('en'));
              }
            },
          ),
          RadioListTile<String>(
            value: 'bn',
            groupValue: selectedLanguage,
            title: const Text('বাংলা'),
            onChanged: (value) {
              if (value != null) {
                languageProvider.changeLanguage(const Locale('bn'));
              }
            },
          ),
        ],
      ),
    );
  }
}