import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          '''
Homeonix respects your privacy and is committed to protecting the personal information you share with us. This Privacy Policy outlines how we collect, use, disclose, and safeguard your data.

1. **Information Collection**:
   - We collect user account information (email, phone) for authentication.
   - Uploaded books, symptoms, and preferences are stored securely.
   - We do not collect any personal medical history unless explicitly provided.

2. **Use of Information**:
   - Data is used to provide remedy suggestions, secure access, and improve the app.
   - Developer-only uploads and logs are accessible only to the verified developer email.

3. **Data Storage**:
   - Data is stored in Firebase Firestore and Firebase Storage.
   - All transmissions are encrypted via HTTPS.

4. **Free Trial & Account Protection**:
   - One free trial per verified user. Multiple accounts using the same device or email/phone will be flagged.

5. **Payments**:
   - Payments are processed securely via trusted gateways.
   - Bank details of the developer are securely linked for subscription payout.

6. **Third-Party Access**:
   - We do not share your data with any third-party services or advertisers.

7. **Account Deletion**:
   - Users can request account deletion at any time. All data will be erased permanently.

8. **Changes**:
   - This policy may update periodically. We’ll notify users on major changes.

For more information, contact: ikbal.hn.dev@gmail.com
          ''',
          style: TextStyle(fontSize: 15.0, height: 1.5),
        ),
      ),
    );
  }
}