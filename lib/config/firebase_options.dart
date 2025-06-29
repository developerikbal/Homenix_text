// File: lib/config/firebase_options.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return android;
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      return windows;
    } else {
      throw UnsupportedError(
        'FirebaseOptions are not configured for this platform.',
      );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBDaOCnS5xyx5q6c6P5YzG373Zn8Q_pXGY',
    appId: '1:483774471149:android:2a3f2a535aec42371365e4',
    messagingSenderId: '483774471149',
    projectId: 'homeonix-8a766',
    storageBucket: 'homeonix-8a766.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'YOUR_WINDOWS_API_KEY',
    appId: 'YOUR_WINDOWS_APP_ID',
    messagingSenderId: 'YOUR_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_PROJECT_ID.appspot.com',
  );
}