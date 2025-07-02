import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../language/language_provider.dart';
import 'package:homeonix/core/secure_storage.dart';

class LanguageController extends GetxController {
  var currentLocale = const Locale('en', 'US').obs;

  final _secureStorage = SecureStorageManager(); // ✅ ইনস্ট্যান্স তৈরি করুন

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  void _loadSavedLanguage() async {
    String? langCode = await _secureStorage.read('app_language'); // ✅ ঠিক করা হয়েছে
    if (langCode != null) {
      currentLocale.value = Locale(langCode);
      Get.updateLocale(currentLocale.value);
    }
  }

  void changeLanguage(String langCode) async {
    currentLocale.value = Locale(langCode);
    await _secureStorage.write('app_language', langCode); // ✅ ঠিক করা হয়েছে
    Get.updateLocale(currentLocale.value);
  }

  String get currentLang => currentLocale.value.languageCode;
}
