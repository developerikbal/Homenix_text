// lib/payment/payment_gateway.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// 📦 Enum: Supported subscription plans
enum SubscriptionPlan { monthly, yearly, lifetime }

/// 💳 Enum: Payment result status
enum PaymentStatus { success, failed, cancelled }

/// 💰 PaymentGateway class handles payment logic (initiate, store logs, update user status)
class PaymentGateway {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🚀 Simulate a payment process (replace with real gateway e.g. Razorpay/Stripe)
  Future<PaymentStatus> initiatePayment({
    required SubscriptionPlan plan,
    required double amount,
    required String method, // Example: 'Razorpay', 'GooglePay', 'Manual'
  }) async {
    try {
      // ✅ Simulate delay for fake payment UI
      debugPrint('Initiating $method payment for plan: $plan with amount: $amount');
      await Future.delayed(Duration(seconds: 2));

      // ✅ Store payment success in Firestore
      await _storePaymentLog(plan, amount, method, PaymentStatus.success);

      // ✅ Update user's premium access
      await _grantPremiumAccess(plan);

      return PaymentStatus.success;
    } catch (e) {
      debugPrint('❌ Payment failed: $e');
      await _storePaymentLog(plan, amount, method, PaymentStatus.failed);
      return PaymentStatus.failed;
    }
  }

  /// 📝 Store transaction details in Firestore
  Future<void> _storePaymentLog(
    SubscriptionPlan plan,
    double amount,
    String method,
    PaymentStatus status,
  ) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('payments').add({
      'uid': user.uid,
      'email': user.email,
      'plan': plan.toString().split('.').last,
      'amount': amount,
      'method': method,
      'status': status.toString().split('.').last,
      'timestamp': Timestamp.now(),
    });
  }

  /// Grant premium access to user based on selected plan
  Future<void> _grantPremiumAccess(SubscriptionPlan plan) async {
    final user = _auth.currentUser;
    if (user == null) return;

    DateTime now = DateTime.now();
    DateTime expiry;

    switch (plan) {
      case SubscriptionPlan.monthly:
        expiry = now.add(Duration(days: 30));
        break;
      case SubscriptionPlan.yearly:
        expiry = now.add(Duration(days: 365));
        break;
      case SubscriptionPlan.lifetime:
        expiry = DateTime(2099, 12, 31); // Far future for lifetime plan
        break;
    }

    await _firestore.collection('users').doc(user.uid).update({
      'isPremium': true,
      'premiumPlan': plan.toString().split('.').last,
      'premiumExpiry': expiry,
    });
  }

  /// Check if current user has an active premium status
  Future<bool> isUserPremium() async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (!doc.exists) return false;

    final data = doc.data()!;
    final expiry = (data['premiumExpiry'] as Timestamp?)?.toDate() ?? DateTime.now();

    return data['isPremium'] == true && DateTime.now().isBefore(expiry);
  }
}