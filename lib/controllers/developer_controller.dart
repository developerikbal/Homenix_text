// File: lib/controllers/developer_controller.dart

import 'dart:io';
import 'package:flutter/material.dart';
import '../services/developer_service.dart';
import '../models/user_model.dart';

class DeveloperController with ChangeNotifier {
  bool _isDeveloper = false;
  bool get isDeveloper => _isDeveloper;

  late UserModel _user;
  UserModel get user => _user;

  /// Set current user and check developer access
  void setUser(UserModel userModel) {
    _user = userModel;
    _checkIfDeveloper(userModel.email);
  }

  /// Verify if user is developer by email
  void _checkIfDeveloper(String email) {
    const String devEmail = 'frontendwebdeveloperikbal@gmail.com';
    _isDeveloper = email.trim().toLowerCase() == devEmail.toLowerCase();
    notifyListeners();
  }

  /// Upload book file (PDF or image) - developer only
  Future<void> uploadBook(File file, {String? fileName}) async {
    try {
      await DeveloperService.uploadBook(file, fileName: fileName);
      await logDebug("Uploaded book: ${file.path}");
    } catch (e) {
      await logDebug("Book upload failed: $e");
      rethrow;
    }
    notifyListeners();
  }

  /// Retrieve list of uploaded book filenames
  Future<List<String>> getUploadHistory() async {
    try {
      return await DeveloperService.getUploadedBookHistory();
    } catch (e) {
      await logDebug("Failed to fetch upload history: $e");
      return [];
    }
  }

  /// Save debug message to local developer log
  Future<void> logDebug(String message) async {
    try {
      await DeveloperService.saveDebugLog(message);
    } catch (_) {
      // Ignore logging errors
    }
  }

  /// Clear uploaded book files (developer only)
  Future<void> clearUploadedFiles() async {
    try {
      await DeveloperService.clearUploads();
      await logDebug("Cleared all uploaded files.");
    } catch (e) {
      await logDebug("Error clearing uploads: $e");
    }
    notifyListeners();
  }

  /// Run unreleased feature simulation for developer testing
  Future<void> runFeatureTest(String featureName) async {
    try {
      await DeveloperService.runSimulation(featureName);
      await logDebug("Feature test run: $featureName");
    } catch (e) {
      await logDebug("Feature simulation failed: $e");
    }
    notifyListeners();
  }

  /// Update metadata (title, tags etc.) for a book
  Future<void> updateBookMetadata(String bookId, Map<String, dynamic> metadata) async {
    try {
      final result = await DeveloperService.updateMetadata(bookId, metadata);
      await logDebug("Metadata updated for $bookId: $result");
    } catch (e) {
      await logDebug("Metadata update failed for $bookId: $e");
    }
    notifyListeners();
  }
}
