// FILE: lib/developer/file_manager.dart
// PURPOSE: Handles all developer-only file operations (PDF uploads, logs, meta files)

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

/// Function: pickPdfFile
/// Purpose: Allow developer to select and upload a book PDF
Future<File?> pickPdfFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null && result.files.single.path != null) {
    return File(result.files.single.path!);
  }
  return null;
}

/// Function: saveFileToInternalStorage
/// Purpose: Store uploaded book PDF inside developer internal directory
Future<String> saveFileToInternalStorage(File file) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/developer/files/uploaded/';
  final fileName = file.path.split('/').last;

  final target = File('$path$fileName');
  await Directory(path).create(recursive: true);
  await file.copy(target.path);
  return target.path;
}

/// Function: writeDebugLog
/// Purpose: Write debug information to logs file
Future<void> writeDebugLog(String log) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/developer/files/logs/debug_logs.txt';

  final logFile = File(path);
  await logFile.create(recursive: true);
  await logFile.writeAsString('$log\n', mode: FileMode.append);
}

/// Function: listUploadedFiles
/// Purpose: Retrieve all uploaded books from internal developer directory
Future<List<FileSystemEntity>> listUploadedFiles() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/developer/files/uploaded/';
  final dir = Directory(path);

  if (await dir.exists()) {
    return dir.listSync();
  } else {
    return [];
  }
}

/// Widget: FileManagerPanel
/// Developer Utility Widget to manage uploaded PDFs and logs
class FileManagerPanel extends StatefulWidget {
  const FileManagerPanel({Key? key}) : super(key: key);

  @override
  State<FileManagerPanel> createState() => _FileManagerPanelState();
}

class _FileManagerPanelState extends State<FileManagerPanel> {
  List<FileSystemEntity> uploadedFiles = [];

  Future<void> _loadFiles() async {
    uploadedFiles = await listUploadedFiles();
    setState(() {});
  }

  Future<void> _uploadPdf() async {
    File? file = await pickPdfFile();
    if (file != null) {
      await saveFileToInternalStorage(file);
      await writeDebugLog('PDF uploaded: ${file.path}');
      await _loadFiles();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Developer File Manager')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _uploadPdf,
            child: const Text('Upload Book PDF'),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: uploadedFiles.length,
              itemBuilder: (context, index) {
                final file = uploadedFiles[index];
                return ListTile(
                  title: Text(file.path.split('/').last),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}