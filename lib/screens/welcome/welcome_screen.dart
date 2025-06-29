import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ✅ Profile Image
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage('assets/images/developer.jpg'), // আপনার ইমেজ path
              ),
            ),

            const SizedBox(height: 30),

            // ✅ Quote
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Respected physician heal lives with remedies, I build bridges with algorithms. Let Homeonix be our common ground.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 15),

            // ✅ Author
            const Text(
              "– programmer ikbal",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),

            const Spacer(),

            // ✅ Login + Signup Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text("login"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text("signup"),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // ✅ Logo & App Name
            Column(
              children: [
                Image.asset(
                  'assets/icons/logo.png',
                  width: 48,
                  height: 48,
                ),
                const SizedBox(height: 5),
                const Text(
                  "HOMEONIX",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}