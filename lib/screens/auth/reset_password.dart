import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSendingReset = false;
  String? _message;

  Future<void> _sendPasswordResetEmail() async {
    setState(() {
      _isSendingReset = true;
      _message = null;
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      setState(() {
        _message = 'Password reset link sent successfully.';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _message = e.message ?? 'An error occurred';
      });
    } finally {
      setState(() {
        _isSendingReset = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Enter your email to receive a password reset link.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address.';
                  }
                  if (!value.contains('@')) {
                    return 'Invalid email format.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              if (_message != null) ...[
                Text(
                  _message!,
                  style: TextStyle(
                    color: _message!.contains('success') ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 10),
              ],
              ElevatedButton(
                onPressed: _isSendingReset
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          _sendPasswordResetEmail();
                        }
                      },
                child: _isSendingReset
                    ? const CircularProgressIndicator()
                    : const Text('Send Reset Link'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}