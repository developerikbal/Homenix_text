// lib/developer/files/logs/debug_logs.dart

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class DebugLogger {
  static final DebugLogger _instance = DebugLogger._internal();

  factory DebugLogger() {
    return _instance;
  }

  DebugLogger._internal();

  File? _logFile;

  /// Initialize the logger and prepare the log file directory.
  Future<void> init() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final logsDir = Directory('${directory.path}/developer/files/logs');
      if (!await logsDir.exists()) {
        await logsDir.create(recursive: true);
      }

      _logFile = File('${logsDir.path}/debug_logs.txt');
      if (!await _logFile!.exists()) {
        await _logFile!.create();
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Logger initialization failed: $e');
      }
    }
  }

  /// Write a message to the debug log file with optional log level.
  Future<void> log(String message, {String level = 'INFO'}) async {
    try {
      final timestamp = DateTime.now().toIso8601String();
      final logEntry = '[$timestamp][$level] $message\n';

      if (_logFile != null) {
        await _logFile!.writeAsString(logEntry, mode: FileMode.append);
      }

      if (kDebugMode) {
        debugPrint(logEntry);
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to write log: $e');
      }
    }
  }

  /// Clear all existing logs (if log file exists).
  Future<void> clearLogs() async {
    try {
      if (_logFile != null && await _logFile!.exists()) {
        await _logFile!.writeAsString('');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to clear logs: $e');
      }
    }
  }

  /// Read and return all logs as a single string.
  Future<String> getLogs() async {
    try {
      if (_logFile != null && await _logFile!.exists()) {
        return await _logFile!.readAsString();
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to read logs: $e');
      }
    }
    return '';
  }

  /// Returns the log file instance for sharing or analysis.
  Future<File?> exportLogs() async {
    try {
      return _logFile;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to export log file: $e');
      }
      return null;
    }
  }
}