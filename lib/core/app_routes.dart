import 'package:flutter/material.dart';

import 'package:homeonix/screens/auth/reset_password_screen.dart';
import 'package:homeonix/screens/auth/splash_screen.dart';
import 'package:homeonix/screens/auth/trial_blocked_screen.dart';
import 'package:homeonix/screens/welcome/welcome_screen.dart';
import 'package:homeonix/screens/auth/login_screen.dart';
import 'package:homeonix/screens/auth/register_screen.dart';

import 'package:homeonix/screens/home/home_screen.dart';
import 'package:homeonix/screens/home/patient_input_screen.dart';
import 'package:homeonix/screens/home/remedy_search_screen.dart';

import 'package:homeonix/screens/remedy/remedy_detail_screen.dart';
import 'package:homeonix/screens/remedy/remedy_compare_screen.dart';
import 'package:homeonix/screens/remedy/remedy_graph_screen.dart';

import 'package:homeonix/screens/book/book_list_screen.dart';
import 'package:homeonix/screens/book/book_detail_screen.dart';

import 'package:homeonix/screens/developer/developer_panel.dart';
import 'package:homeonix/screens/developer/upload_book_screen.dart';
import 'package:homeonix/screens/developer/upload_image_screen.dart';
// import 'package:homeonix/screens/developer/book_metadata_editor.dart'; // unused or not found
import 'package:homeonix/screens/developer/book_translator_screen.dart';

import 'package:homeonix/screens/settings/settings_screen.dart';
import 'package:homeonix/screens/settings/language_screen.dart';
import 'package:homeonix/screens/settings/darkmode_toggle.dart';

import 'package:homeonix/screens/common/unauthorized_screen.dart';
import 'package:homeonix/screens/common/not_found_screen.dart';

// ✅ Import Models
import 'package:homeonix/models/remedy_model.dart';
import 'package:homeonix/models/book_model.dart';

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
  // static const String bookMetadata = '/developer/book-metadata'; // unused or not found
  static const String translateBook = '/developer/translate-book';

  static const String settings = '/settings';
  static const String language = '/settings/language';
  static const String darkModeToggle = '/settings/darkmode';

  static const String unauthorized = '/unauthorized';
  static const String notFound = '/404';

  static final Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    welcome: (_) => const WelcomeScreen(),
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    resetPassword: (_) => const ResetPasswordScreen(),
    trialBlocked: (_) => const TrialBlockedScreen(),

    home: (_) => const HomeScreen(),
    inputSymptoms: (_) => const PatientInputScreen(),
    searchRemedy: (_) => const RemedySearchScreen(),

    // RemedyDetailScreen
    remedyDetail: (_) => RemedyDetailScreen(
      remedy: RemedyModel(
        id: 'demo',
        name: 'Demo Remedy',
        badgeType: RemedyBadgeType.values.first, // enum-এর প্রথম ভ্যালু
        createdAt: DateTime.now(),
        grade: 0,
        keynote: '',
        potency: '',
        symptoms: const [],
      ),
    ),
    remedyCompare: (_) => RemedyCompareScreen(
      remedy1: RemedyModel(
        id: '1',
        name: 'Remedy A',
        badgeType: RemedyBadgeType.values.first,
        createdAt: DateTime.now(),
        grade: 1,
        keynote: '',
        potency: '',
        symptoms: const [],
      ),
      remedy2: RemedyModel(
        id: '2',
        name: 'Remedy B',
        badgeType: RemedyBadgeType.values.first,
        createdAt: DateTime.now(),
        grade: 2,
        keynote: '',
        potency: '',
        symptoms: const [],
      ),
    ),
    remedyGraph: (_) => const RemedyGraphScreen(),

    bookList: (_) => const BookListScreen(),
    bookDetail: (_) => BookDetailScreen(
      book: BookModel(
        id: 'demoBook',
        // শুধু বিদ্যমান ও প্রয়োজনীয় ফিল্ড দিন
        name: 'Demo Book',
        addedBy: 'admin',
        author: 'Anonymous',
        category: 'General',
        filePath: '',
        isDeleted: false,
        isTranslated: false,
        isVerified: false,
        language: 'en',
        pageCount: 100,
        remarks: '',
        title: 'Demo Book',
        uploadDate: DateTime.now(),
      ),
    ),

    developerPanel: (_) => const DeveloperPanel(),
    uploadBook: (_) => const UploadBookScreen(),
    uploadImage: (_) => const UploadImageScreen(),
    // bookMetadata: (_) => BookMetadataEditorScreen(bookId: 'demoBookId'), // undefined, commented out
    translateBook: (_) => const BookTranslatorScreen(),

    settings: (_) => const SettingsScreen(),
    language: (_) => const LanguageScreen(),
    darkModeToggle: (_) => const DarkModeToggle(),

    unauthorized: (_) => const UnauthorizedScreen(),
    notFound: (_) => const NotFoundScreen(),
  };
}
