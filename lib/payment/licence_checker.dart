// lib/payment/licence_checker.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// ক্লাস: LicenceChecker
///  কাজ: ইউজারের প্রিমিয়াম লাইসেন্স স্ট্যাটাস যাচাই করে লোকাল স্টোরেজ ও UI কে তথ্য দেয়
class LicenceChecker {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  /// মেথড: checkLicenceStatus
  /// কাজ: ইউজারের ইমেইল অনুযায়ী Firestore থেকে লাইসেন্স তথ্য সংগ্রহ করে
  /// এবং SecureStorage-এ সংরক্ষণ করে, রিটার্ন করে প্রিমিয়াম কিনা
  Future<bool> checkLicenceStatus(String userEmail) async {
    try {
      final docSnapshot =
          await _firestore.collection('licenses').doc(userEmail).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        final bool isPremium = data?['isPremium'] ?? false;
        final String expiry = data?['expiryDate'] ?? '';

        // লোকালি Secure Storage-এ Cache করে রাখা
        await _secureStorage.write(key: 'isPremium', value: isPremium.toString());
        await _secureStorage.write(key: 'expiryDate', value: expiry);

        return isPremium;
      } else {
        return false;
      }
    } catch (e) {
      print("Licence Checking Error: $e");
      return false;
    }
  }

  /// মেথড: getCachedLicenceStatus
  /// কাজ: সিকিউর স্টোরেজ থেকে শেষ জানা প্রিমিয়াম স্ট্যাটাস রিটার্ন করে
  Future<bool> getCachedLicenceStatus() async {
    final value = await _secureStorage.read(key: 'isPremium');
    return value == 'true';
  }

  /// 🧹 মেথড: clearLicenceCache
  /// কাজ: Secure Storage থেকে সমস্ত লাইসেন্স তথ্য মুছে দেয়
  Future<void> clearLicenceCache() async {
    await _secureStorage.delete(key: 'isPremium');
    await _secureStorage.delete(key: 'expiryDate');
  }
}

// Inside LicenceChecker class

static Future<bool> validate(String licenseKey) async {
  // এই মেথডটি dummy হিসেবে কাজ করছে
  // পরে Firestore বা অন্যত্র থেকে license key verify করতে পারো
  return licenseKey == 'VALID_LIFETIME_KEY'; // Temporary validation logic
}