// lib/services/developer_unlock_service.dart

import 'package:firebase_auth/firebase_auth.dart';

class DeveloperUnlockService {
  static const String _developerEmail = 'frontendwebdeveloperikbal@gmail.com';

  /// Returns true if the currently signed-in user's email matches the developer's email.
  static Future<bool> isDeveloper() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      // Check if user is signed in and has a verified email
      if (user != null && user.email != null && user.emailVerified) {
        return user.email == _developerEmail;
      } else {
        return false;
      }
    } catch (e) {
      // Handle unexpected FirebaseAuth errors
      return false;
    }
  }

  /// Returns the currently signed-in developer's email, or null
  static Future<String?> getDeveloperEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      return user?.email;
    } catch (e) {
      return null;
    }
  }
}