// lib/app.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // ✅ ঠিক Import

import 'config/firebase_options.dart';
import 'core/app_routes.dart';
import 'core/themes.dart';
import 'services/auth_service.dart';
import 'controllers/language_controller.dart';

class HomeonixApp extends StatelessWidget {
  const HomeonixApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LanguageController());

    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Homeonix',
          locale: languageController.currentLocale.value,
          fallbackLocale: const Locale('en', 'US'),
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: AppRoutes.splash,
          routes: AppRoutes.routes,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
          const Locale('en', 'US'),
          const Locale('bn', 'BD'),
          ],
        ));
  }
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthService());
  Get.put(LanguageController());

  runApp(const HomeonixApp());
}
