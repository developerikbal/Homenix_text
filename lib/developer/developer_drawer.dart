import 'dart:io'; // প্রয়োজন File class এর জন্য

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'file_manager.dart'; // Uploaded file info loader
import 'package:homeonix/widgets/section_divider.dart'; // Custom divider widget
import 'package:homeonix/theme/light_theme.dart'; // Light theme colors

class UploadHistoryView extends StatefulWidget {
  const UploadHistoryView({Key? key}) : super(key: key);

  @override
  State<UploadHistoryView> createState() => _UploadHistoryViewState();
}

class _UploadHistoryViewState extends State<UploadHistoryView> {
  List<UploadedFile> uploadedFiles = [];

  // Uploaded files local or Firebase থেকে লোড করার method
  Future<void> loadUploadedFiles() async {
    final files = await FileManager.loadUploadedFiles();
    setState(() {
      uploadedFiles = files;
    });
  }

  // initState এ লোড হবে widget তৈরির সময়
  @override
  void initState() {
    super.initState();
    loadUploadedFiles();
  }

  // Upload time format
  String formatTimestamp(DateTime time) {
    return DateFormat('dd MMM yyyy • hh:mm a').format(time);
  }

  // প্রতিটি file entry view
  Widget buildFileTile(UploadedFile file) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
        title: Text(file.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text("Uploaded on ${formatTimestamp(file.uploadedAt)}"),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Open File?"),
              content: Text(file.name),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    FileManager.openFile(file.path);
                  },
                  child: const Text("Open"),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // UI build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload History"),
        backgroundColor: AppColors.primaryGreen,
      ),
      body: Column(
        children: [
          const SectionDivider(title: "Recently Uploaded Books"),
          Expanded(
            child: uploadedFiles.isEmpty
                ? const Center(child: Text("No files uploaded yet."))
                : ListView.builder(
                    itemCount: uploadedFiles.length,
                    itemBuilder: (context, index) {
                      return buildFileTile(uploadedFiles[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// Optional: Debug log viewer
class DebugLogViewer extends StatelessWidget {
  const DebugLogViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: File('lib/developer/files/logs/debug_logs.txt').readAsString(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error reading log file."));
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Text(snapshot.data ?? "No logs available."),
          );
        }
      },
    );
  }
}