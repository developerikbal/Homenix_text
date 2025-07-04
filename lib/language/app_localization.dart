// File: lib/language/app_localization.dart import 'dart:convert'; import 'package:flutter/material.dart'; import 'package:flutter/services.dart';

class AppLocalizations { final Locale locale; AppLocalizations(this.locale);

static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

static AppLocalizations of(BuildContext context) { return Localizations.of<AppLocalizations>(context, AppLocalizations)!; }

late Map<String, String> _localizedStrings;

Future<bool> load() async { final jsonString = await rootBundle.loadString('assets/language/${locale.languageCode}.json'); final Map<String, dynamic> jsonMap = json.decode(jsonString); _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString())); return true; }

String translate(String key) { return _localizedStrings[key] ?? key; } }

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> { const _AppLocalizationsDelegate();

@override bool isSupported(Locale locale) => ['en', 'bn'].contains(locale.languageCode);

@override Future<AppLocalizations> load(Locale locale) async { final localization = AppLocalizations(locale); await localization.load(); return localization; }

@override bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false; }

