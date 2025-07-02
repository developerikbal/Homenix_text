import 'package:get/get.dart';
import '../language/language_provider.dart';

class LanguageController extends GetxController {
  final LanguageProvider languageProvider = LanguageProvider();

  @override
  void onInit() {
    super.onInit();
    languageProvider.fetchLocale(); // App start এ language load
  }

  void toggleLanguage() {
    languageProvider.toggleLanguage();
  }

  void setLanguage(AppLanguage lang) {
    languageProvider.changeLanguage(lang);
  }

  Locale get currentLocale => languageProvider.appLocale;
}
