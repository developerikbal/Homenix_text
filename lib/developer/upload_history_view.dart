import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'file_manager.dart'; // ⬅️ For loading uploaded file info (lib/developer/file_manager.dart)
import 'package:homeonix/widgets/section_divider.dart'; // ⬅️ Custom divider widget
import 'package:homeonix/theme/light_theme.dart'; // ⬅️ Light theme colors (lib/theme/light_theme.dart)

class UploadHistoryView extends StatefulWidget {
  const UploadHistoryView({Key? key}) : super(key: key);

  @override
  State<UploadHistoryView> createState() => _UploadHistoryViewState();
}

class _UploadHistoryViewState extends State<UploadHistoryView> {
  List<UploadedFile> uploadedFiles = [];

  /// ⬇️ Load uploaded file history from local storage or backend
  /// Related service file: lib/services/firebase_storage_service.dart
  Future<void> loadUploadedFiles() async {
    final files = await FileManager.loadUploadedFiles();
    setState(() {
      uploadedFiles = files;
    });
  }

  /// ⬇️ Initialize and load files on widget build
  @override
  void initState() {
    super.initState();
    loadUploadedFiles();
  }

  /// ⬇️ Show formatted timestamp
  String formatTimestamp(DateTime time) {
    return DateFormat('dd MMM yyyy • hh:mm a').format(time);
  }

  /// ⬇️ UI card for each uploaded file entry
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
          // ⬇️ Handle view or download
          // Related function: FileManager.openFile(file.path);
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

  /// ⬇️ Main build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload History"),
        backgroundColor: AppColors.primaryGreen,
      ),
      body: Column(
        children: [
          const SectionDivider(title: "Recently Uploaded Books"), // Custom Widget
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

// Read from log file and display as text
Widget buildLogViewer() {
  return FutureBuilder<String>(
    future: File('lib/developer/files/logs/debug_logs.txt').readAsString(),
    builder: (context, snapshot) {
      return SingleChildScrollView(
        child: Text(snapshot.data ?? "No logs available."),
      );
    },
  );
}