import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homeonix/core/secure_storage.dart';

final _storage = SecureStorage();
await _storage.writeSecureData('userToken', token);
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Email Sign In
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!result.user!.emailVerified) {
        await result.user!.sendEmailVerification();
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Please verify your email before signing in.',
        );
      }
      return result.user;
    } catch (e) {
      debugPrint("Login Error: $e");
      return null;
    }
  }

  // Email Sign Up with Verification
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await result.user!.sendEmailVerification();
      return result.user;
    } catch (e) {
      debugPrint("Signup Error: $e");
      return null;
    }
  }

  // Forgot Password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint("Reset Password Error: $e");
    }
  }

  // Realtime Auth State Changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint("Sign Out Error: $e");
    }
  }

  // Get Current Logged-in User
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Phone Number Verification
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(PhoneAuthCredential) onVerificationCompleted,
    required Function(FirebaseAuthException) onVerificationFailed,
    required Function(String verificationId, int? resendToken) onCodeSent,
    required Function(String verificationId) onAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificationFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: onAutoRetrievalTimeout,
    );
  }

  // Sign in with Phone OTP
  Future<User?> signInWithPhoneCredential(PhoneAuthCredential credential) async {
    try {
      final result = await _auth.signInWithCredential(credential);
      return result.user;
    } catch (e) {
      debugPrint("Phone OTP SignIn Error: $e");
      return null;
    }
  }

  // Google Sign In
  Future<User?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result = await _auth.signInWithCredential(credential);
      return result.user;
    } catch (e) {
      debugPrint("Google Sign In Error: $e");
      return null;
    }
  }

  // Email Verified Check
  Future<bool> isEmailVerified() async {
    User? user = _auth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  // Developer Email Check for unlocking features
  Future<bool> isDeveloperEmail(String email) async {
    return email == "frontendwebdeveloperikbal@gmail.com";
  }

  // Check for Premium User (Used in premium features lock/unlock)
  Future<bool> isPremiumUser() async {
    User? user = _auth.currentUser;
    if (user == null) return false;
    final claims = await user.getIdTokenResult(true);
    return claims.claims?['premium'] == true;
  }
}

Future<User?> signInWithEmailAndPassword(String email, String password) async {
  try {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (!credential.user!.emailVerified) {
      throw FirebaseAuthException(
        code: 'email-not-verified',
        message: 'Please verify your email before logging in.',
      );
    }

    return credential.user;
  } catch (e) {
    rethrow;
  }
}