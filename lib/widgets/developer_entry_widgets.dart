import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../developer/control_panel.dart';
import '../services/developer_unlock_service.dart';

class DeveloperEntryWidget extends StatefulWidget {
  const DeveloperEntryWidget({super.key});

  @override
  State<DeveloperEntryWidget> createState() => _DeveloperEntryWidgetState();
}

class _DeveloperEntryWidgetState extends State<DeveloperEntryWidget> {
  bool _isDeveloper = false;
  bool _checkingStatus = true;

  @override
  void initState() {
    super.initState();
    _checkDeveloperStatus();
  }

  Future<void> _checkDeveloperStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final isDev = await DeveloperUnlockService.isDeveloper(user.email);
      setState(() {
        _isDeveloper = isDev;
        _checkingStatus = false;
      });
    } else {
      setState(() {
        _checkingStatus = false;
      });
    }
  }

  void _navigateToControlPanel() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DeveloperControlPanel()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingStatus) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!_isDeveloper) {
      return const SizedBox.shrink(); // Hide if not developer
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton.icon(
        onPressed: _navigateToControlPanel,
        icon: const Icon(Icons.developer_mode),
        label: const Text('Developer Control Panel'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}