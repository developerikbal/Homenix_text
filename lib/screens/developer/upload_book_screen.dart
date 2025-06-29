import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class UploadBookScreen extends StatefulWidget {
  const UploadBookScreen({Key? key}) : super(key: key);

  @override
  State<UploadBookScreen> createState() => _UploadBookScreenState();
}

class _UploadBookScreenState extends State<UploadBookScreen> {
  File? selectedFile;
  bool isUploading = false;
  String uploadStatus = '';
  final TextEditingController titleController = TextEditingController();

  /// PDF   
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  /// Firebase Storage-    Firestore-  
  Future<void> uploadFile() async {
    if (selectedFile == null || titleController.text.trim().isEmpty) {
      setState(() {
        uploadStatus = '     ';
      });
      return;
    }

    setState(() {
      isUploading = true;
      uploadStatus = 'Uploading...';
    });

    try {
      String bookId = const Uuid().v4();
      String fileName = '${bookId}_${selectedFile!.path.split('/').last}';

      final ref = FirebaseStorage.instance.ref().child('books/$fileName');
      await ref.putFile(selectedFile!);

      final downloadUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('books').doc(bookId).set({
        'id': bookId,
        'title': titleController.text.trim(),
        'fileUrl': downloadUrl,
        'uploadedAt': Timestamp.now(),
      });

      setState(() {
        uploadStatus = '   ';
        selectedFile = null;
        titleController.clear();
      });
    } catch (e) {
      setState(() {
        uploadStatus = 'Upload  : ${e.toString()}';
      });
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload New Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ///   
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Book Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            /// PDF   
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text('Pick PDF File'),
              onPressed: pickFile,
            ),

            if (selectedFile != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Selected: ${selectedFile!.path.split('/').last}',
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            ///  
            ElevatedButton(
              onPressed: isUploading ? null : uploadFile,
              child: isUploading
                  ? const CircularProgressIndicator()
                  : const Text('Upload Book'),
            ),

            const SizedBox(height: 20),

            ///   
            Text(
              uploadStatus,
              style: TextStyle(
                color: uploadStatus.contains('')
                    ? Colors.green
                    : uploadStatus.contains('')
                        ? Colors.red
                        : isDark ? Colors.white60 : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}