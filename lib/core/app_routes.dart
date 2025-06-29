import 'package:flutter/material.dart';

// Auth Screens
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/reset_password.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/auth/trial_blocked_screen.dart';

// Welcome
import '../screens/common/welcome_screen.dart';

// Home Screens
import '../screens/home/home_screen.dart';
import '../screens/home/patient_input_screen.dart';
import '../screens/home/remedy_search_screen.dart';

// Remedy Screens
import '../screens/remedy/remedy_detail_screen.dart';
import '../screens/remedy/remedy_compare_screen.dart';
import '../screens/remedy/remedy_graph_screen.dart';

// Book Screens
import '../screens/book/book_list_screen.dart';
import '../screens/book/book_detail_screen.dart';

// Developer Screens
import '../screens/developer/developer_panel.dart';
import '../screens/developer/upload_book_screen.dart';
import '../screens/developer/upload_image_screen.dart';
import '../screens/developer/book_metadata_editor.dart';
import '../screens/developer/book_translator_screen.dart';

// Settings Screens
import '../screens/settings/settings_screen.dart';
import '../screens/settings/language_screen.dart';
import '../screens/settings/darkmode_toggle.dart';

// Common Screens
import '../screens/common/unauthorized_screen.dart';
import '../screens/common/not_found_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String resetPassword = '/reset-password';
  static const String trialBlocked = '/trial-blocked';

  static const String home = '/home';
  static const String inputSymptoms = '/input';
  static const String searchRemedy = '/remedy/search';

  static const String remedyDetail = '/remedy/detail';
  static const String remedyCompare = '/remedy/compare';
  static const String remedyGraph = '/remedy/graph';

  static const String bookList = '/books';
  static const String bookDetail = '/book/detail';

  static const String developerPanel = '/developer';
  static const String uploadBook = '/developer/upload-book';
  static const String uploadImage = '/developer/upload-image';
  static const String bookMetadata = '/developer/book-metadata';
  static const String translateBook = '/developer/translate-book';

  static const String settings = '/settings';
  static const String language = '/settings/language';
  static const String darkModeToggle = '/settings/darkmode';

  static const String unauthorized = '/unauthorized';
  static const String notFound = '/404';
// app_routes.dart
'/privacy-policy': (context) => const PrivacyPolicyScreen(),
  static Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    welcome: (_) => const WelcomeScreen(),
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    resetPassword: (_) => const ResetPasswordScreen(),
    trialBlocked: (_) => const TrialBlockedScreen(),

    home: (_) => const HomeScreen(),
    inputSymptoms: (_) => const PatientInputScreen(),
    searchRemedy: (_) => const RemedySearchScreen(),

    remedyDetail: (_) => const RemedyDetailScreen(),
    remedyCompare: (_) => const RemedyCompareScreen(),
    remedyGraph: (_) => const RemedyGraphScreen(),

    bookList: (_) => const BookListScreen(),
    bookDetail: (_) => const BookDetailScreen(),

    developerPanel: (_) => const DeveloperPanel(),
    uploadBook: (_) => const UploadBookScreen(),
    uploadImage: (_) => const UploadImageScreen(),
    bookMetadata: (_) => const BookMetadataEditorScreen(),
    translateBook: (_) => const BookTranslatorScreen(),

    settings: (_) => const SettingsScreen(),
    language: (_) => const LanguageScreen(),
    darkModeToggle: (_) => const DarkModeToggle(),

    unauthorized: (_) => const UnauthorizedScreen(),
    notFound: (_) => const NotFoundScreen(),
  };
}