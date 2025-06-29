// lib/developer/control_panel.dart

import 'package:flutter/material.dart';

// Importing necessary developer screens
import '../developer/upload_books.dart';
import '../developer/file_manager.dart';
import '../developer/book_metadata_editor.dart';
import '../developer/upload_history_view.dart';
import '../developer/test_feature_runner.dart';
import '../payment/payment_ui.dart';
import '../services/developer_unlock_service.dart';

class DeveloperControlPanel extends StatelessWidget {
  const DeveloperControlPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Developer Control Panel"),
        backgroundColor: Colors.green.shade700,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTile(context, "Upload Books", Icons.upload_file, const UploadBooksScreen()),
          _buildTile(context, "File Manager", Icons.folder, const FileManagerScreen()),
          _buildTile(context, "Edit Book Metadata", Icons.edit, const BookMetadataEditorScreen()),
          _buildTile(context, "Upload History", Icons.history, const UploadHistoryViewScreen()),
          _buildTile(context, "Test Features", Icons.science, const TestFeatureRunnerScreen()),
          _buildTile(context, "Manage Payment Setup", Icons.payment, const PaymentSetupScreen()),
          _buildTile(context, "Unlock Developer Access", Icons.lock_open, const DeveloperUnlockWidget()),
        ],
      ),
    );
  }

  // Reusable tile builder for each feature
  Widget _buildTile(BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.green.shade700),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
      ),
    );
  }
}