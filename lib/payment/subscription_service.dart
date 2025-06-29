// lib/payment/subscription_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// SubscriptionService manages trial, monthly, yearly, and lifetime subscriptions.
/// Stores user-specific subscription info in Firestore (under 'subscriptions' collection).
class SubscriptionService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Check if the current user has an active subscription.
  Future<bool> isUserSubscribed() async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final doc = await _firestore.collection('subscriptions').doc(user.uid).get();
    if (!doc.exists) return false;

    final data = doc.data();
    final expiry = data?['expiresAt']?.toDate();
    if (expiry == null) return false;

    return DateTime.now().isBefore(expiry);
  }

  /// Create or update a subscription (monthly, yearly, or lifetime).
  Future<void> activateSubscription({
    required String type, // "monthly", "yearly", or "lifetime"
    required Duration duration,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }

    final now = DateTime.now();
    final expiry = type == "lifetime" ? DateTime(9999) : now.add(duration);

    await _firestore.collection('subscriptions').doc(user.uid).set({
      'type': type,
      'activatedAt': now,
      'expiresAt': expiry,
    });
  }

  /// Start a one-time free trial (available only once per user).
  Future<void> startTrialIfNotUsed() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final doc = await _firestore.collection('subscriptions').doc(user.uid).get();
    if (doc.exists && doc.data()?['type'] == 'trial') return;

    await _firestore.collection('subscriptions').doc(user.uid).set({
      'type': 'trial',
      'activatedAt': DateTime.now(),
      'expiresAt': DateTime.now().add(Duration(days: 30)),
    });
  }

  /// Get the current subscription type: "trial", "monthly", "yearly", "lifetime", or "none".
  Future<String> getCurrentPlan() async {
    final user = _auth.currentUser;
    if (user == null) return 'none';

    final doc = await _firestore.collection('subscriptions').doc(user.uid).get();
    if (!doc.exists) return 'none';

    final data = doc.data();
    final expiry = data?['expiresAt']?.toDate();
    if (expiry == null || DateTime.now().isAfter(expiry)) return 'none';

    return data?['type'] ?? 'none';
  }

  /// Allow admin or developer to force update a user's plan (for testing or override).
  Future<void> setPlanManually({
    required String userId,
    required String type,
    required Duration duration,
  }) async {
    final now = DateTime.now();
    final expiry = type == "lifetime" ? DateTime(9999) : now.add(duration);

    await _firestore.collection('subscriptions').doc(userId).set({
      'type': type,
      'activatedAt': now,
      'expiresAt': expiry,
    });
  }
}

Future<void> updateTrialDays(String userId, int newTrialDays) async {
  final doc = _firestore.collection('subscriptions').doc(userId);
  await doc.update({
    'trial_start': FieldValue.serverTimestamp(),
    'trial_days': newTrialDays,
  });
}