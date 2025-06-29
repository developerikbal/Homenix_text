import 'package:flutter/material.dart';

/// App-wide constants, branding, and static config for Homeonix

// App Info
const String kAppName = "Homeonix";
const String kAppSlogan = "Your Smart Homeopathic Guide";
const String kAppVersion = "1.0.0";
const String kAppQuote = 'Homeonix is my heartfelt offering to support your healing journey.';

// Developer Contact Info
const String kDeveloperName = 'Ikbal (Flutter Developer & Homeopathic Practitioner)';
const String kDeveloperEmail = 'frontendwebdeveloperikbal@gmail.com';
const String kDeveloperWhatsApp = '+918638799119';
const String kDeveloperAllowedEmail = 'frontendwebdeveloperikbal@gmail.com';

// External URLs
const String kPrivacyPolicyUrl = 'https://your-website.com/privacy';
const String kTermsUrl = 'https://your-website.com/terms';
const String kGoogleFormFeedbackUrl = 'https://forms.gle/your-google-form-link';

// Firebase Collection Names
const String kUsersCollection = 'users';
const String kBooksCollection = 'books';
const String kRemediesCollection = 'remedies';
const String kSymptomsCollection = 'symptoms';
const String kUploadsCollection = 'developer_uploads';
const String kPaymentsCollection = 'payments';

// Subscription Plan Identifiers
const String kPlanMonthly = 'monthly_plan';
const String kPlanYearly = 'yearly_plan';
const String kPlanLifetime = 'lifetime_plan';

// Free Trial Settings
const int kFreeTrialDays = 30;
const int kMaxTrialDevicesPerUser = 1;

// App Colors
class AppColors {
  static const Color primary = Color(0xFF4CAF50); // Light green
  static const Color accent = Color(0xFF81C784);  // Soft green
  static const Color text = Color(0xFF212121);    // Dark text
  static const Color background = Color(0xFFF5F5F5); // Light grey
  static const Color error = Color(0xFFD32F2F);    // Error red
}

// Language
const String defaultLangCode = "en";
const List<String> supportedLanguages = ["en", "bn"];

// Asset Paths
const String kLogoPath = 'assets/images/homeonix_logo.png';
const String kDefaultBookCover = 'assets/images/default_book.png';
const String firebaseStorageBooks = "books/";
const String firebaseStorageImages = "images/";

// Timings
const Duration kDefaultAnimationDuration = Duration(milliseconds: 300);
const Duration kSplashDuration = Duration(seconds: 2);
const Duration kToastDuration = Duration(seconds: 3);

// AI/Remedy Logic
const int maxSymptomsPerInput = 10;
const double remedyMatchThreshold = 0.7;

// Feature Toggles
class FeatureFlags {
  static const bool enableImageDetection = true;
  static const bool enableVoiceInput = true;
  static const bool enableAutoTranslate = true;
  static const bool restrictTrialRepeat = true;
  static const bool enableRealTimeControlPanel = true;
  static const bool enableSymptomAnalysis = true;
}

// Fonts
const String kFontHeading = 'Montserrat';
const String kFontBody = 'Lato';
const String kFontButton = 'Nunito';

// SVG Icons
class AppIcons {
  static const String home = "assets/icons/home.svg";
  static const String remedy = "assets/icons/remedy.svg";
  static const String book = "assets/icons/book.svg";
  static const String settings = "assets/icons/settings.svg";
  static const String upload = "assets/icons/upload.svg";
}

// Storage Keys
const String userLoginKey = "USER_LOGGED_IN";
const String developerUnlockedKey = "DEVELOPER_UNLOCKED";
const String appThemeKey = "APP_THEME_MODE";

// Section Titles
class SectionTitles {
  static const String developerTools = "Developer Tools";
  static const String remedyAnalysis = "Remedy Analysis";
  static const String bookUpload = "Upload New Books";
  static const String paymentSection = "Upgrade to Premium";
  static const String symptomEntry = "Enter Patient's Symptoms";
}

// Static Disclaimer
const String disclaimerText = "This app is not a substitute for professional medical advice.";