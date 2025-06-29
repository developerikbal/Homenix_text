import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// SubscriptionValidator handles user subscription status checking
/// Includes free trial, premium plans, and developer override access.
class SubscriptionValidator {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Check if the current user is subscribed (trial, monthly, yearly, lifetime)
  Future<bool> isUserSubscribed() async {
    final User? user = _auth.currentUser;

    // Developer override (full access for developer)
    if (user?.email == 'frontendwebdeveloperikbal@gmail.com') {
      return true;
    }

    if (user == null) return false;

    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await _firestore.collection('users').doc(user.uid).get();

    if (!userDoc.exists) return false;

    final data = userDoc.data()!;
    final String plan = data['subscriptionPlan'] ?? 'free';
    final Timestamp? expiry = data['expiryDate'];

    if (plan == 'lifetime') return true;

    if (expiry != null) {
      final DateTime now = DateTime.now();
      final DateTime expiryDate = expiry.toDate();
      if (expiryDate.isAfter(now)) {
        return true;
      }
    }

    return false;
  }

  /// Check if the user already used their free trial
  Future<bool> hasUsedFreeTrial() async {
    final User? user = _auth.currentUser;
    if (user == null) return true;

    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await _firestore.collection('users').doc(user.uid).get();

    if (!userDoc.exists) return false;

    final data = userDoc.data()!;
    return data['usedFreeTrial'] == true;
  }

  /// Mark the user as having used the free trial
  Future<void> markFreeTrialUsed() async {
    final User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'usedFreeTrial': true,
      'subscriptionPlan': 'trial',
      'expiryDate': Timestamp.fromDate(
        DateTime.now().add(Duration(days: 30)),
      ),
    }, SetOptions(merge: true));
  }

  /// Update user's subscription info after payment
  Future<void> updateSubscription({
    required String plan, // 'monthly', 'yearly', or 'lifetime'
    required DateTime expiryDate,
  }) async {
    final User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'subscriptionPlan': plan,
      'expiryDate': Timestamp.fromDate(expiryDate),
    }, SetOptions(merge: true));
  }

  /// Reset user's subscription manually (if needed for admin/dev use)
  Future<void> resetSubscription() async {
    final User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'subscriptionPlan': 'free',
      'usedFreeTrial': true,
      'expiryDate': null,
    }, SetOptions(merge: true));
  }
}