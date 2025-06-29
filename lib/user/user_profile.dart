// 📁 Path: lib/user/user_profile.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// ✅ This screen displays the profile info of a signed-in user
/// ⚙️ Firebase Auth & Firestore Integration

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  // 📁 Suggested move: lib/services/user_service.dart
  /// ✅ Load user data from Firestore
  Future<void> _loadUserData() async {
    _user = _auth.currentUser;
    if (_user != null) {
      try {
        final DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(_user!.uid).get();

        if (snapshot.exists) {
          setState(() {
            _userData = snapshot.data() as Map<String, dynamic>;
            _isLoading = false;
          });
        }
      } catch (e) {
        debugPrint("❌ Error loading user data: $e");
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // 📁 Suggested move: lib/controllers/auth_controller.dart
  /// ✅ Sign out current user
  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("👤 User Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      body: _userData != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("📧 Email: ${_user?.email}"),
                  const SizedBox(height: 8),
                  Text("👤 Name: ${_userData!['name'] ?? 'N/A'}"),
                  const SizedBox(height: 8),
                  Text("📱 Phone: ${_userData!['phone'] ?? 'N/A'}"),
                  const SizedBox(height: 8),
                  Text("🕒 Joined: ${_userData!['joined'] ?? 'Unknown'}"),
                ],
              ),
            )
          : const Center(
              child: Text("No user data found."),
            ),
    );
  }
}