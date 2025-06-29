import 'package:flutter/material.dart';
import '../services/firebase_auth_service.dart';
import '../services/developer_unlock_service.dart';
import '../developer/upload_books.dart';
import '../developer/upload_history_view.dart';
import '../widgets/custom_button.dart';

class DevOnlyTools extends StatelessWidget {
  const DevOnlyTools({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Developer Tools"),
        backgroundColor: Colors.green.shade800,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Developer Debug Tools Panel",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          const SizedBox(height: 20),

          // Firebase Auth test button
          CustomButton(
            label: "Test Firebase Auth",
            onPressed: () async {
              try {
                final message = await FirebaseAuthService.testFirebaseAuth();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Auth test failed: $e")));
              }
            },
          ),

          // Developer unlock check
          CustomButton(
            label: "Check Developer Unlock",
            onPressed: () async {
              final isDev = await DeveloperUnlockService.isDeveloper(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isDev
                      ? "Developer Access granted"
                      : "Not a Developer"),
                ),
              );
            },
          ),

          // Upload history viewer
          CustomButton(
            label: "View Upload History",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UploadHistoryView()),
              );
            },
          ),

          // Debug log (placeholder dialog only)
          CustomButton(
            label: "View Debug Log",
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Debug Logs"),
                  content: const Text(
                    "Logs are stored in /lib/developer/files/logs/debug_logs.txt",
                  ),
                ),
              );
            },
          ),

          // License check simulation
          CustomButton(
            label: "Test License Validity",
            onPressed: () async {
              // Mock logic
              final valid = await Future.delayed(
                const Duration(seconds: 1),
                () => true,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(valid
                      ? "Valid License"
                      : "Invalid License"),
                ),
              );
            },
          ),

          // Firestore debug write test (mock or real)
          CustomButton(
            label: "Test Firestore Write",
            onPressed: () async {
              try {
                // Replace with actual function when ready
                // await FirestoreService.writeDummyData();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Dummy write to Firestore executed")),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Firestore write failed: $e")),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}