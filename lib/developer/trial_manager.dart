import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class TrialManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get device unique ID for Android or Windows
  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id ?? androidInfo.androidId ?? 'unknown_android_id';
      } else if (Platform.isWindows) {
        final windowsInfo = await deviceInfo.windowsInfo;
        return windowsInfo.deviceId ?? windowsInfo.computerName ?? 'unknown_windows_id';
      } else {
        return 'unsupported_device';
      }
    } catch (e) {
      debugPrint('Error fetching device ID: $e');
      return 'device_id_error';
    }
  }

  // Check if trial is already used on this device
  Future<bool> hasUsedTrial() async {
    try {
      final deviceId = await getDeviceId();
      final doc = await _firestore.collection('trials').doc(deviceId).get();
      return doc.exists;
    } catch (e) {
      debugPrint('Error checking trial status: $e');
      return true; // Fail-safe: treat as used
    }
  }

  // Save trial record when user activates trial
  Future<void> activateTrial() async {
    try {
      final deviceId = await getDeviceId();
      final user = _auth.currentUser;
      if (user == null) throw FirebaseAuthException(code: 'no-user', message: 'User not logged in');

      final data = {
        'deviceId': deviceId,
        'userId': user.uid,
        'email': user.email,
        'startedAt': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem,
      };

      await _firestore.collection('trials').doc(deviceId).set(data);
    } catch (e) {
      debugPrint('Error activating trial: $e');
      rethrow;
    }
  }

  // Check if trial period has expired (default: 30 days)
  Future<bool> isTrialExpired({int trialDays = 30}) async {
    try {
      final deviceId = await getDeviceId();
      final doc = await _firestore.collection('trials').doc(deviceId).get();

      if (!doc.exists) return false;

      final startedAt = doc.data()?['startedAt'];
      if (startedAt is Timestamp) {
        final startDate = startedAt.toDate();
        final now = DateTime.now();
        return now.difference(startDate).inDays >= trialDays;
      }

      return false;
    } catch (e) {
      debugPrint('Error checking trial expiry: $e');
      return true; // Fail-safe: expire trial
    }
  }
}