import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LoggerService {
  static final LoggerService _instance = LoggerService._internal();

  factory LoggerService() => _instance;

  LoggerService._internal();

  /// Append a debug message with timestamp to log file
  Future<void> logDebug(String message) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final developerPath = Directory('${directory.path}/developer/files/logs');

      if (!await developerPath.exists()) {
        await developerPath.create(recursive: true);
      }

      final logFile = File('${developerPath.path}/debug_logs.txt');
      final timestamp = DateTime.now().toIso8601String();
      final logEntry = '[$timestamp] $message\n';

      await logFile.writeAsString(logEntry, mode: FileMode.append);
    } catch (e) {
      // Optional: You can handle errors or print them in debug mode
      print("LoggerService error: $e");
    }
  }

  /// Optionally clear logs (developer-only)
  Future<void> clearLogs() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final logFile = File('${directory.path}/developer/files/logs/debug_logs.txt');

      if (await logFile.exists()) {
        await logFile.writeAsString('');
      }
    } catch (e) {
      print("Error clearing logs: $e");
    }
  }

  /// Optional: Get full log content
  Future<String> getLogs() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final logFile = File('${directory.path}/developer/files/logs/debug_logs.txt');

      if (await logFile.exists()) {
        return await logFile.readAsString();
      } else {
        return '';
      }
    } catch (e) {
      print("Error reading logs: $e");
      return '';
    }
  }
}