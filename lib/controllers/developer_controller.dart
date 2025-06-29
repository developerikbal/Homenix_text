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

  // Set current user and check developer access
  void setUser(UserModel userModel) {
    _user = userModel;
    _checkIfDeveloper(userModel.email);
  }

  // Verify if user is developer by email
  void _checkIfDeveloper(String email) {
    const String devEmail = 'frontendwebdeveloperikbal@gmail.com';
    _isDeveloper = email.trim().toLowerCase() == devEmail.toLowerCase();
    notifyListeners();
  }

  // Upload book (developer-only)
  Future<void> uploadBook(File file) async {
    try {
      await DeveloperService.uploadBook(file);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  // Retrieve upload history
  Future<List<String>> getUploadHistory() async {
    try {
      return await DeveloperService.getUploadedBookHistory();
    } catch (e) {
      return [];
    }
  }

  // Save local log
  Future<void> logDebug(String message) async {
    try {
      await DeveloperService.saveDebugLog(message);
    } catch (_) {}
  }

  // Delete all developer-uploaded files
  Future<void> clearUploadedFiles() async {
    try {
      await DeveloperService.clearUploads();
    } catch (_) {}
    notifyListeners();
  }

  // Simulate unreleased feature (developer-only)
  Future<void> runFeatureTest(String feature) async {
    try {
      await DeveloperService.runSimulation(feature);
    } catch (_) {}
    notifyListeners();
  }

  // Update book metadata (title, author, tags, etc.)
  Future<void> updateBookMetadata(String bookId, Map<String, dynamic> metadata) async {
    try {
      await DeveloperService.updateMetadata(bookId, metadata);
    } catch (_) {}
    notifyListeners();
  }
}