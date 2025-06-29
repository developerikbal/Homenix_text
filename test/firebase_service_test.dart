// 🔎 Test File: firebase_service_test.dart
// ✅ Purpose: To test all major Firebase services integrated in Homeonix app.
// 🧪 Coverage: FirebaseAuth, Firestore, Firebase Storage, Connectivity

import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// 🛠️ Service Imports (with file paths)
// From: lib/services/firebase_auth_service.dart
import 'package:homeonix/services/firebase_auth_service.dart';

// From: lib/services/firestore_service.dart
import 'package:homeonix/services/firestore_service.dart';

// From: lib/services/firebase_storage_service.dart
import 'package:homeonix/services/firebase_storage_service.dart';

// From: lib/services/connectivity_service.dart
import 'package:homeonix/services/connectivity_service.dart';

void main() {
  group('🔐 FirebaseAuthService Tests', () {
    final authService = FirebaseAuthService();

    test('Sign In Anonymously', () async {
      final user = await authService.signInAnonymously();
      expect(user, isNotNull);
      expect(user.uid, isNotEmpty);
    });

    test('Get Current User', () {
      final user = authService.getCurrentUser();
      expect(user, isA<User>());
    });
  });

  group('🗃️ FirestoreService Tests', () {
    final firestoreService = FirestoreService();

    test('Write and Read from Firestore', () async {
      const collection = 'test_users';
      final data = {'name': 'Ikbal', 'role': 'developer'};
      await firestoreService.setData(collection, 'ikbal', data);

      final fetched =
          await firestoreService.getData(collection: collection, docId: 'ikbal');

      expect(fetched?['name'], 'Ikbal');
      expect(fetched?['role'], 'developer');
    });
  });

  group('📦 FirebaseStorageService Tests', () {
    final storageService = FirebaseStorageService();

    test('Get Upload URL', () async {
      const path = 'test_uploads/sample.txt';
      final ref = storageService.getReference(path);

      expect(ref.fullPath, path);
    });
  });

  group('🌐 ConnectivityService Tests', () {
    final connectivityService = ConnectivityService();

    test('Check Connectivity', () async {
      final result = await connectivityService.checkConnection();
      expect(result, isA<ConnectivityResult>());
    });
  });
}