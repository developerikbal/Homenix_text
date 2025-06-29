import 'package:flutter/material.dart';

/// NotFoundScreen: ব্যবহারকারী ভুল পাথ বা route-এ গেলে এই স্ক্রিন দেখানো হয়।
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 20),
            const Text(
              'Oops! Page not found.',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'The page you are looking for doesn’t exist\nor has been moved.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // হোম স্ক্রিনে ফিরে যাওয়া — যদি '/home' রেজিস্টার না থাকে, তাহলে fallback দেওয়া উচিত
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', 
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(Icons.home),
              label: const Text('Go to Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}