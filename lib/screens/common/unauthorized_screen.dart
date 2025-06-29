import 'package:flutter/material.dart';
import '../../widgets/common_button.dart';
import '../../core/constants.dart';
import '../../core/app_routes.dart';

class UnauthorizedScreen extends StatelessWidget {
  const UnauthorizedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light mode default
      appBar: AppBar(
        title: const Text('Unauthorized Access'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.lock_outline,
                size: 80,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 20),

              const Text(
                'আপনার এই ফিচারটি অ্যাক্সেস করার অনুমতি নেই।',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 30),

              CommonButton(
                label: 'লগইন করুন',
                color: AppColors.primaryColor,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
                child: const Text(
                  'হোম পেইজে ফিরে যান',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}