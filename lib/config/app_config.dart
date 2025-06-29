import 'package:flutter/foundation.dart';

/// App-wide environment configurations
class AppConfig {
  static const String appName = 'Homeonix';

  /// Whether the app is running in production mode
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');

  /// Firebase Collection Names
  static const String userCollection = 'users';
  static const String remedyCollection = 'remedies';
  static const String bookCollection = 'books';
  static const String uploadsCollection = 'uploads';
  static const String paymentCollection = 'payments';

  /// Developer Email for Unlock
  static const String developerEmail = 'frontendwebdeveloperikbal@gmail.com';

  /// Payment Settings
  static const String currencySymbol = '';
  static const String premiumPlanMonthly = 'monthly';
  static const String premiumPlanYearly = 'yearly';
  static const String premiumPlanLifetime = 'lifetime';

  /// Free Trial Restrictions
  static const int maxTrialDays = 30;
  static const bool allowMultipleTrialEmails = false;

  /// App Support Links
  static const String whatsappContact = '+918638799119';
  static const String feedbackFormUrl = 'https://forms.gle/your-google-form-link';
  static const String supportEmail = 'ikbal.helpdesk@gmail.com';

  /// App Identity
  static const String androidPackageName = 'com.homeonix.app';
  static const String windowsExecutableName = 'Homeonix.exe';

  /// Firebase Configuration Check (for debug builds)
  static void verifyFirebaseConfig() {
    if (!kIsWeb && androidPackageName.isEmpty) {
      throw Exception('Firebase configuration missing. Please ensure google-services.json is added.');
    }
  }
}