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

  static Future<void> saveDebugLog(String message) async {
    try {
      final file = await _getLogFile();
      final timestamp = DateTime.now().toIso8601String();
      await file.writeAsString('[$timestamp] $message\n', mode: FileMode.append);
    } catch (e) {
      if (kDebugMode) print("Logging failed: $e");
    }
  }
}

class DeveloperUploader {
  static Future<void> uploadBook(File file, {String? fileName}) async {
    final dir = await getApplicationDocumentsDirectory();
    final uploadDir = Directory('${dir.path}/developer/uploaded');

    if (!await uploadDir.exists()) {
      await uploadDir.create(recursive: true);
    }

    final destFile = File('${uploadDir.path}/${fileName ?? file.path.split('/').last}');
    await file.copy(destFile.path);
    await DeveloperLogger.saveDebugLog("Uploaded file: ${file.path}");
  }

  static Future<void> clearUploads() async {
    final dir = await getApplicationDocumentsDirectory();
    final uploadDir = Directory('${dir.path}/developer/uploaded');
    if (await uploadDir.exists()) {
      await uploadDir.delete(recursive: true);
      await uploadDir.create(recursive: true);
    }
  }

  static Future<List<String>> getUploadedBookHistory() async {
    final dir = await getApplicationDocumentsDirectory();
    final uploadDir = Directory('${dir.path}/developer/uploaded');
    if (!await uploadDir.exists()) return [];

    final files = uploadDir.listSync().whereType<File>();
    return files.map((f) => f.path.split('/').last).toList();
  }
}

class DeveloperSimulation {
  static Future<void> runSimulation(String featureName) async {
    await DeveloperLogger.saveDebugLog("Simulating feature: $featureName");
    // TODO: Add actual simulation logic here
  }
}

class MetadataUpdater {
  static Future<String> updateMetadata(String bookId, Map<String, dynamic> metadata) async {
    await DeveloperLogger.saveDebugLog("Updating metadata for $bookId: $metadata");
    // TODO: Update logic (possibly saving to a local JSON/db)
    return "Metadata updated successfully.";
  }
}

class DeveloperAccessControl {
  static const allowedEmail = "frontendwebdeveloperikbal@gmail.com";

  static bool isDeveloper(String? userEmail) {
    return userEmail != null && userEmail.trim().toLowerCase() == allowedEmail.toLowerCase();
  }
}

class DeveloperService {
  static Future<void> uploadBook(File file, {String? fileName}) =>
      DeveloperUploader.uploadBook(file, fileName: fileName);

  static Future<void> clearUploads() => DeveloperUploader.clearUploads();

  static Future<List<String>> getUploadedBookHistory() =>
      DeveloperUploader.getUploadedBookHistory();

  static Future<void> saveDebugLog(String message) =>
      DeveloperLogger.saveDebugLog(message);

  static Future<void> runSimulation(String featureName) =>
      DeveloperSimulation.runSimulation(featureName);

  static Future<String> updateMetadata(String bookId, Map<String, dynamic> metadata) =>
      MetadataUpdater.updateMetadata(bookId, metadata);

  static bool isDeveloper(String? email) =>
      DeveloperAccessControl.isDeveloper(email);
}
