import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

class LocalizationService extends Translations {
  static const fallbackLocale = Locale('en', 'US');

  static final locale = _getLocaleFromDevice();

  static final langs = ['English', ''];

  static final locales = [
    Locale('en', 'US'),
    Locale('bn', 'BD'),
  ];

  static Locale _getLocaleFromDevice() {
    final String deviceLanguageCode = window.locale.languageCode;
    switch (deviceLanguageCode) {
      case 'bn':
        return Locale('bn', 'BD');
      case 'en':
      default:
        return Locale('en', 'US');
    }
  }

  static void changeLocale(String lang) {
    final index = langs.indexOf(lang);
    if (index >= 0 && index < locales.length) {
      final selectedLocale = locales[index];
      Get.updateLocale(selectedLocale);
    }
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'app_name': 'Homeonix',
          'welcome': 'Welcome',
          'login': 'Login',
          'register': 'Register',
          'email': 'Email',
          'password': 'Password',
          'logout': 'Logout',
          'remedy': 'Remedy',
          'search': 'Search',
          'language': 'Language',
          'settings': 'Settings',
        },
        'bn_BD': {
          'app_name': '',
          'welcome': '',
          'login': '',
          'register': '',
          'email': '',
          'password': '',
          'logout': '',
          'remedy': '',
          'search': '',
          'language': '',
          'settings': '',
        },
      };
}