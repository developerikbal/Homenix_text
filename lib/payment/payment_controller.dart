// lib/payment/payment_controller.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'subscription_service.dart';
import 'payment_gateway.dart';
import 'licence_checker.dart';
import 'transaction_history.dart';

/// ক্লাস: PaymentController
/// কাজ: ইউজারের সাবস্ক্রিপশন স্টেট ম্যানেজ, পেমেন্ট প্রসেস ও লাইসেন্স যাচাই করা
class PaymentController with ChangeNotifier {
  // ইউজারের বর্তমান সাবস্ক্রিপশন স্ট্যাটাস
  bool _isPremium = false;
  String _activePlan = 'free';

  bool get isPremium => _isPremium;
  String get activePlan => _activePlan;

  ///  লগইন করার পর Firebase থেকে সাবস্ক্রিপশন তথ্য লোড করে
  Future<void> loadSubscriptionStatus() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    final data = doc.data();
    if (data != null && data['subscription'] != null) {
      _activePlan = data['subscription']['plan'] ?? 'free';
      _isPremium = _activePlan != 'free';
    }

    notifyListeners();
  }

  /// নির্দিষ্ট প্ল্যানের জন্য পেমেন্ট শুরু করে
  Future<bool> initiatePayment(String plan) async {
    try {
      final success = await PaymentGateway.processPayment(plan);
      if (success) {
        await _updateSubscription(plan);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(' Payment error: $e');
      return false;
    }
  }

  /// লাইফটাইম লাইসেন্স থাকলে সেটি দিয়ে সাবস্ক্রিপশন রিনিউ করে
  Future<void> renewWithLicense(String licenseKey) async {
    final isValid = await LicenceChecker.validate(licenseKey);
    if (isValid) {
      await _updateSubscription('lifetime');
    }
  }

  /// ইউজারের সাবস্ক্রিপশন Firebase এ আপডেট করে
  Future<void> _updateSubscription(String plan) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final subscriptionData = {
      'plan': plan,
      'startedAt': DateTime.now().toIso8601String(),
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'subscription': subscriptionData});

    _activePlan = plan;
    _isPremium = plan != 'free';

    // লোকাল ট্রানজ্যাকশন হিস্টোরি সংরক্ষণ
    await TransactionHistory.save(uid, plan);

    notifyListeners();
  }

  /// ৩০ দিনের ট্রায়াল শেষ হয়েছে কিনা যাচাই করে
  Future<bool> isTrialExpired() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return true;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    final trialStart = doc.data()?['subscription']?['startedAt'];
    if (trialStart == null) return true;

    final startDate = DateTime.parse(trialStart);
    final now = DateTime.now();
    final diff = now.difference(startDate).inDays;

    return diff > 30; // 30 দিন পর ট্রায়াল শেষ
  }

  /// প্রিমিয়াম স্ক্রিনে ইউজার ঢুকতে পারবে কিনা যাচাই করে
  bool canAccessPremium() {
    return _isPremium;
  }
}