// File: lib/screens/settings/language_screen.dart

import 'package:flutter/material.dart';
import 'language_toggle.dart'; // Language toggle widget import

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Language Settings"),
        backgroundColor: Colors.green.shade700,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LanguageToggle(), // Custom language toggle component
            ],
          ),
        ),
      ),
    );
  }
}