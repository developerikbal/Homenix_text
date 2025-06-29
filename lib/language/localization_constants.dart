import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

/// ভাষা কোডের জন্য Constant
const String ENGLISH = 'en';
const String BANGLA = 'bn';

/// ইউজার পছন্দের ভাষা সংরক্ষণের key
const String LANGUAGE_CODE_KEY = 'language_code';

/// লোকাল ডেটা স্টোরেজ (GetStorage instance)
final GetStorage _storage = GetStorage();

/// ইউজার পছন্দ অনুযায়ী Locale রিটার্ন করে
Locale getLocale() {
  final String? code = _storage.read(LANGUAGE_CODE_KEY);
  if (code == null || code.isEmpty) {
    return const Locale(ENGLISH); // ডিফল্ট English
  }
  return Locale(code);
}

/// ইউজার পছন্দ অনুযায়ী Locale সেট করে সংরক্ষণ করে
Future<void> setLocale(String languageCode) async {
  await _storage.write(LANGUAGE_CODE_KEY, languageCode);
}

/// ভাষার নাম রিটার্ন করে (UI দেখানোর জন্য)
String getLanguageName(String code) {
  switch (code) {
    case ENGLISH:
      return "English";
    case BANGLA:
      return "বাংলা";
    default:
      return "English";
  }
}

/// সমর্থিত ভাষার তালিকা (Flutter MaterialApp এর জন্য)
List<Locale> supportedLocales = const [
  Locale(ENGLISH),
  Locale(BANGLA),
];

/// UI Dropdown বা ভাষা পরিবর্তনের জন্য অপশন তালিকা
List<Map<String, String>> languageOptions = [
  {'code': ENGLISH, 'label': 'English'},
  {'code': BANGLA, 'label': 'বাংলা'},
];