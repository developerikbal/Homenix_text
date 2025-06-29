import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homeonix/services/auth_service.dart';
import 'package:homeonix/widgets/custom_button.dart';
import 'package:homeonix/widgets/custom_textfield.dart';
import 'package:homeonix/core/constants.dart';
import 'package:homeonix/core/secure_storage.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();

  bool isLoading = false;
  String errorText = '';

  Future<void> handleRegister() async {
    final email = emailCtrl.text.trim();
    final password = passwordCtrl.text.trim();
    final confirm = confirmCtrl.text.trim();

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      errorText = '';
    });

    if (password != confirm) {
      setState(() {
        errorText = "Passwords do not match.";
        isLoading = false;
      });
      return;
    }

    try {
      final exists = await AuthService().checkIfTrialExists(email);
      if (exists) {
        setState(() {
          errorText = "This device or email already used a free trial.";
          isLoading = false;
        });
        return;
      }

      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.sendEmailVerification();
      await SecureStorage.saveUserEmail(email);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Verification email sent. Please verify before login.")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorText = e.message ?? "Registration failed.";
      });
    } catch (_) {
      setState(() {
        errorText = "Unexpected error occurred.";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                controller: emailCtrl,
                labelText: "Email",
                keyboardType: TextInputType.emailAddress,
                validator: (val) =>
                    val == null || !val.contains('@') ? "Enter a valid email" : null,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: passwordCtrl,
                labelText: "Password",
                obscureText: true,
                validator: (val) =>
                    val != null && val.length < 6 ? "Password must be at least 6 characters" : null,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: confirmCtrl,
                labelText: "Confirm Password",
                obscureText: true,
                validator: (val) =>
                    val != passwordCtrl.text ? "Passwords do not match" : null,
              ),
              const SizedBox(height: 20),
              if (errorText.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(errorText, style: const TextStyle(color: Colors.red)),
                ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      text: "Register",
                      onPressed: handleRegister,
                    ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: const Text("Already have an account? Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}