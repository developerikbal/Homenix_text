import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:homeonix/services/firebase_storage_service.dart';
import 'package:homeonix/widgets/custom_button.dart';
import 'package:homeonix/developer/upload_history_view.dart';
import 'package:homeonix/utils/pdf_to_text.dart';

class UploadBooksScreen extends StatefulWidget {
  const UploadBooksScreen({Key? key}) : super(key: key);

  @override
  State<UploadBooksScreen> createState() => _UploadBooksScreenState();
}

class _UploadBooksScreenState extends State<UploadBooksScreen> {
  String? _selectedFileName;
  bool _isUploading = false;
  String _uploadStatus = '';

  /// Step 1: Select PDF, extract text, upload to Firebase
  Future<void> _processAndUploadPdf() async {
    setState(() {
      _isUploading = true;
      _uploadStatus = "Processing PDF...";
    });

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      final file = result.files.single;
      _selectedFileName = file.name;

      try {
        // Extract text from PDF
        final extractedText = await PdfToText.extractText(file.path!);

        // Upload to Firebase Storage
        await FirebaseStorageService.uploadBookFile(file.path!, file.name);

        // Show success
        setState(() {
          _uploadStatus = "Uploaded successfully: $_selectedFileName";
        });

        // Optionally save extractedText locally or to Firestore
      } catch (e) {
        setState(() {
          _uploadStatus = "Upload failed: ${e.toString()}";
        });
      }
    } else {
      setState(() {
        _uploadStatus = "No file selected.";
      });
    }

    setState(() {
      _isUploading = false;
    });
  }

  /// Step 2: Navigate to upload history screen
  void _goToUploadHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const UploadHistoryView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Book (PDF)"),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: "View Upload History",
            onPressed: _goToUploadHistory,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Select a book (PDF) to upload and process:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            CustomButton(
              label: "Choose & Upload PDF",
              onPressed: _isUploading ? null : _processAndUploadPdf,
            ),
            const SizedBox(height: 20),
            if (_isUploading) const CircularProgressIndicator(),
            const SizedBox(height: 10),
            if (_uploadStatus.isNotEmpty)
              Text(_uploadStatus, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}