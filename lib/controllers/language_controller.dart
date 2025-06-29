//lib/controllers/language_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../language/language_provider.dart';
import '../services/secure_storage.dart';

class LanguageController extends GetxController {
  /// Reactive Locale object
  var currentLocale = const Locale('en', 'US').obs;

  /// Called when controller is initialized
  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  /// Load previously saved language code from secure storage
  void _loadSavedLanguage() async {
    String? langCode = await SecureStorage.read('app_language');
    if (langCode != null) {
      currentLocale.value = Locale(langCode);
      Get.updateLocale(currentLocale.value);
    }
  }

  /// Change app language and persist it in secure storage
  void changeLanguage(String langCode) async {
    currentLocale.value = Locale(langCode);
    await SecureStorage.write('app_language', langCode);
    Get.updateLocale(currentLocale.value);
  }

  /// Get current language code (e.g., 'en', 'bn')
  String get currentLang => currentLocale.value.languageCode;
}