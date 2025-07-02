// TrialBlockedScreen: shown when user's free trial has expired

import 'package:flutter/material.dart';
import 'package:homeonix/widgets/common_button.dart';
import 'package:homeonix/services/auth_service.dart';
import 'package:homeonix/services/subscription_service.dart';
import 'package:homeonix/core/constants.dart';
import 'package:homeonix/core/themes.dart';

class TrialBlockedScreen extends StatelessWidget {
  const TrialBlockedScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Icon(Icons.lock_outline, size: 64, color: Colors.grey.shade700),

              const SizedBox(height: 24),

              const Text(

                "Your trial has expired",

                style: TextStyle(

                  fontSize: 22,

                  fontWeight: FontWeight.bold,

                ),

              ),

              const SizedBox(height: 12),

              const Text(

                "Please upgrade to a premium plan to continue using Homeonix.",

                textAlign: TextAlign.center,

                style: TextStyle(fontSize: 16),

              ),

              const SizedBox(height: 24),

              CommonButton(

                label: "Upgrade Plan",

                onPressed: () {

                  Navigator.pushNamed(context, '/payment');

                },

              ),

              const SizedBox(height: 12),

              TextButton(

                onPressed: () async {

                  await AuthService().signOut();

                  Navigator.pushReplacementNamed(context, '/login');

                },

                child: const Text("Logout"),

              )

            ],

          ),

        ),

      ),

    );

  }

}
