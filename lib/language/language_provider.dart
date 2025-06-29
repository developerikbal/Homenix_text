import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Supported languages enum
enum AppLanguage { english, bengali }

/// LanguageProvider manages the current locale state
class LanguageProvider extends ChangeNotifier {
  static const String _languageKey = 'app_language';

  /// Default language set to English
  Locale _appLocale = const Locale('en');

  Locale get appLocale => _appLocale;

  /// Load saved locale from persistent storage (SharedPreferences)
  Future<void> fetchLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString(_languageKey);

    if (languageCode != null && languageCode.isNotEmpty) {
      _appLocale = Locale(languageCode);
    } else {
      _appLocale = const Locale('en'); // fallback default
    }

    notifyListeners();
  }

  /// Change app language and persist it
  Future<void> changeLanguage(AppLanguage language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (language) {
      case AppLanguage.english:
        _appLocale = const Locale('en');
        await prefs.setString(_languageKey, 'en');
        break;
      case AppLanguage.bengali:
        _appLocale = const Locale('bn');
        await prefs.setString(_languageKey, 'bn');
        break;
    }

    notifyListeners();
  }

  /// Toggle between English and Bengali dynamically
  Future<void> toggleLanguage() async {
    final isEnglish = _appLocale.languageCode == 'en';
    await changeLanguage(isEnglish ? AppLanguage.bengali : AppLanguage.english);
  }
}