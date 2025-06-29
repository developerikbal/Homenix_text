// 📁 path: lib/user/auth_controller.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Email Sign Up with Verification
  Future<String?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.sendEmailVerification();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Unknown error occurred.';
    }
  }

  // Email Login with Verification Check
  Future<String?> loginWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);

      if (!userCredential.user!.emailVerified) {
        await _auth.signOut(); // Block unverified login
        return "Please verify your email before logging in.";
      }

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Login failed due to an unknown error.';
    }
  }

  // Logout & Clear Session
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await _auth.signOut();
    } catch (_) {}
  }

  // Get Current User (if logged in)
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Resend Email Verification Link
  Future<void> resendEmailVerification() async {
    try {
      if (_auth.currentUser != null && !_auth.currentUser!.emailVerified) {
        await _auth.currentUser!.sendEmailVerification();
      }
    } catch (_) {}
  }

  // Check if User is Signed In & Verified
  bool isLoggedIn() {
    final user = _auth.currentUser;
    return user != null && user.emailVerified;
  }

  // Free Trial Check by Email
  Future<bool> hasUsedTrial(String email) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("trial_used_$email") ?? false;
  }

  // Mark Free Trial as Used
  Future<void> markTrialAsUsed(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("trial_used_$email", true);
  }

  // Forgot Password / Reset
  Future<String?> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (_) {
      return "Password reset failed.";
    }
  }
}