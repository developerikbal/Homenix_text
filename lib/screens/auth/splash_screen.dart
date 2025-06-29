// lib/screens/auth/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homeonix/core/constants.dart';
import 'package:homeonix/core/app_routes.dart';
import 'package:homeonix/services/subscription_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/animations/splash_loading.json',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp(); // Start initialization
  }

  Future<void> _initializeApp() async {
    // Delay to show logo for branding
    await Future.delayed(const Duration(seconds: 2));

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Not logged in — go to login screen
      Get.offAllNamed(AppRoutes.login);
    } else {
      // Reload user data
      await user.reload();
      final refreshedUser = FirebaseAuth.instance.currentUser;

      if (refreshedUser != null && refreshedUser.emailVerified) {
        // If email is verified, check subscription/trial
        bool trialExpired =
            await SubscriptionService().isTrialExpired(refreshedUser.uid);

        if (trialExpired) {
          // Trial expired — go to payment page
          Get.offAllNamed(AppRoutes.payment);
        } else {
          // Everything okay — go to home page
          Get.offAllNamed(AppRoutes.home);
        }
      } else {
        // Email not verified — go to verification screen
        Get.offAllNamed(AppRoutes.verifyEmail);
      }
    }
  }
// Example inside splash_screen.dart
return StreamBuilder<User?>(
  stream: FirebaseAuth.instance.authStateChanges(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else if (snapshot.hasData && snapshot.data!.emailVerified) {
      return const RemedySearchScreen();
    } else if (snapshot.hasData && !snapshot.data!.emailVerified) {
      return const EmailVerificationScreen();
    } else {
      return const LoginScreen();
    }
  },
);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            Image.asset(
              'assets/images/homeonix_logo.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            const Text(
              'Analyzing your access...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}