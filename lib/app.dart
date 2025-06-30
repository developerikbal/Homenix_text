import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/firebase_options.dart';
import 'core/app_routes.dart'; // Ensure it exports a List<GetPage>
import 'core/themes.dart'; // Define AppThemes class with lightTheme & darkTheme
import 'language/app_localization.dart'; // Define AppLocalization extending Translations
import 'services/auth_service.dart';
import 'controllers/language_controller.dart';

class HomeonixApp extends StatelessWidget {
  const HomeonixApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController langController = Get.find<LanguageController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Homeonix',
      translations: AppLocalization(),
      locale: langController.currentLocale.value, // Use `.value` to extract Locale from Rx<Locale>
      fallbackLocale: const Locale('en', 'US'),
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.pages,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('bn', 'BD'),
      ],
    );
  }
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inject essential services before running app
  Get.put(AuthService());
  Get.put(LanguageController());

  runApp(const HomeonixApp());
}
