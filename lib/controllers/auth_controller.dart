// lib/controllers/auth_controller.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onReady() {
    super.onReady();
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  // SIGN UP with email and password
  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await cred.user!.updateDisplayName(name);
      await cred.user!.sendEmailVerification(); // Email verification mandatory

      Get.snackbar("Registration Success", "Please verify your email before login.");
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Registration Failed", e.message ?? "Unknown error");
    }
  }

  // SIGN IN
  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (!userCred.user!.emailVerified) {
        await _auth.signOut();
        Get.snackbar("Verification Required", "Please verify your email before logging in.");
        return;
      }

      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Failed", e.message ?? "Unknown error");
    }
  }

  // SIGN OUT
  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }

  // PASSWORD RESET
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      Get.snackbar("Password Reset", "Password reset link sent to your email.");
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Unknown error");
    }
  }

  // GET CURRENT USER
  User? get currentUser => _auth.currentUser;
}
