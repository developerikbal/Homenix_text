import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import '../developer/dev_logger.dart'; //   logDebug   

class UploadService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Uploads PDF file to Firebase Storage
  Future<void> uploadPDF(File file, String uploadedBy) async {
    try {
      final fileName = basename(file.path);
      final storageRef = _storage.ref().child('uploaded_books/$fileName');

      final uploadTask = storageRef.putFile(file);

      await uploadTask.whenComplete(() => null);
      logDebug("Book Upload -> '$fileName' uploaded by $uploadedBy");

    } catch (e) {
      logDebug("Upload Error -> ${e.toString()}");
      rethrow;
    }
  }
}