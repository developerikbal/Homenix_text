import 'package:flutter/material.dart';
import 'package:homeonix/developer/upload_books.dart';
import 'package:homeonix/developer/file_manager.dart';
import 'package:homeonix/developer/upload_history_view.dart';
import 'package:homeonix/developer/book_metadata_editor.dart';
import 'package:homeonix/payment/payment_ui.dart';
import 'package:homeonix/developer/dev_only_tools.dart';
import 'package:homeonix/user/user_model.dart'; // user role model
import 'package:homeonix/utils/role_guard.dart'; // role-based access control
import 'package:homeonix/user/auth_controller.dart'; // current user logic/controller

class DeveloperPanel extends StatelessWidget {
  const DeveloperPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Developer Control Panel"),
        backgroundColor: Colors.green[700],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [

          ListTile(
            leading: const Icon(Icons.upload_file),
            title: const Text("Upload New Books (PDF)"),
            subtitle: const Text("Process and auto-integrate books into database."),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UploadBooksScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text("Manage Uploaded Files"),
            subtitle: const Text("See all uploaded PDFs and translation results."),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FileManagerScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("Upload History"),
            subtitle: const Text("View uploaded books and timestamps."),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UploadHistoryView()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.edit_document),
            title: const Text("Edit Book Metadata"),
            subtitle: const Text("Modify name, author, language, category etc."),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BookMetadataEditor()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Manage Payments & Plans"),
            subtitle: const Text("Setup bank accounts and subscription packages."),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PaymentManagementUI()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.build),
            title: const Text("Developer Utilities"),
            subtitle: const Text("Test features, view logs, simulate uploads."),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DevOnlyTools()),
              );
            },
          ),
        ],
      ),
    );
  }
}