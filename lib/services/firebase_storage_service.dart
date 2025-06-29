// File: lib/services/firebase_storage_service.dart

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload a file to a specific [path] in Firebase Storage
  Future<String?> uploadFile({
    required File file,
    required String path,
  }) async {
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = await ref.putFile(file);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Firebase Storage Upload Error: $e');
      return null;
    }
  }

  /// Delete a file from Firebase Storage by [path]
  Future<void> deleteFile(String path) async {
    try {
      final ref = _storage.ref().child(path);
      await ref.delete();
    } catch (e) {
      print('Firebase Storage Delete Error: $e');
    }
  }

  /// Get download URL of a file in Firebase Storage by [path]
  Future<String?> getDownloadUrl(String path) async {
    try {
      final ref = _storage.ref().child(path);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Firebase Storage GetDownloadUrl Error: $e');
      return null;
    }
  }

  /// Check if a file exists at the given [path]
  Future<bool> fileExists(String path) async {
    try {
      final ref = _storage.ref().child(path);
      final metadata = await ref.getMetadata();
      return metadata != null;
    } catch (e) {
      return false;
    }
  }
}