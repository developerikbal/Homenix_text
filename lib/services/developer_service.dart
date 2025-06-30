// File: lib/services/developer_service.dart
// Description: Developer-only utilities - upload, logs, permission check.

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class DeveloperLogger {
  static Future<File> _getLogFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final logDir = Directory('${dir.path}/developer/logs');

    if (!await logDir.exists()) {
      await logDir.create(recursive: true);
    }

    final file = File('${logDir.path}/debug_logs.txt');
    if (!await file.exists()) {
      await file.create();
    }

    return file;
  }

  static Future<void> log(String message) async {
    try {
      final file = await _getLogFile();
      final timestamp = DateTime.now().toIso8601String();
      await file.writeAsString('[$timestamp] $message\n', mode: FileMode.append);
    } catch (e) {
      if (kDebugMode) {
        print("Logging failed: $e");
      }
    }
  }
}

class DeveloperUploader {
  static Future<void> uploadPDF(File file) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final uploadDir = Directory('${dir.path}/developer/uploaded');

      if (!await uploadDir.exists()) {
        await uploadDir.create(recursive: true);
      }

      final dest = File('${uploadDir.path}/${file.path.split('/').last}');
      await file.copy(dest.path);
      await DeveloperLogger.log("Uploaded file: ${file.path}");
    } catch (e) {
      await DeveloperLogger.log("Upload failed: $e");
    }
  }
}

class UploadHistoryService {
  static Future<List<String>> listUploadedFiles() async {
    final dir = await getApplicationDocumentsDirectory();
    final uploadDir = Directory('${dir.path}/developer/uploaded');

    if (!await uploadDir.exists()) {
      return [];
    }

    final files = uploadDir.listSync().whereType<File>();
    return files.map((file) => file.path.split('/').last).toList();
  }
}

class DeveloperAccessControl {
  static const allowedEmail = "frontendwebdeveloperikbal@gmail.com";

  static bool isDeveloper(String? userEmail) {
    return userEmail != null && userEmail == allowedEmail;
  }
}

/// NEW WRAPPER CLASS TO FIX ERROR:
class DeveloperService {
  static Future<void> log(String message) => DeveloperLogger.log(message);

  static Future<void> uploadPDF(File file) => DeveloperUploader.uploadPDF(file);

  static Future<List<String>> getUploadedFiles() => UploadHistoryService.listUploadedFiles();

  static bool isDeveloper(String? email) => DeveloperAccessControl.isDeveloper(email);
}
