import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// Compress image before uploading
/// 
/// [file] → original image file to compress  
/// [quality] → quality from 0 to 100 (default: 80)  
/// Returns a new [File] that is compressed or null if failed
Future<File?> compressImageFile(File file, {int quality = 80}) async {
  try {
    final tempDir = await getTemporaryDirectory();
    final targetPath = path.join(
      tempDir.path,
      "compressed_${DateTime.now().millisecondsSinceEpoch}${path.extension(file.path)}",
    );

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: quality,
      format: _getImageFormat(file.path),
    );

    if (compressedFile != null && compressedFile.existsSync()) {
      return compressedFile;
    }
  } catch (e) {
    print("Image compression failed: $e");
  }

  return null;
}

/// Determine image format for compression
CompressFormat _getImageFormat(String filePath) {
  final ext = path.extension(filePath).toLowerCase();
  switch (ext) {
    case '.jpg':
    case '.jpeg':
      return CompressFormat.jpeg;
    case '.png':
      return CompressFormat.png;
    case '.webp':
      return CompressFormat.webp;
    case '.heic':
      return CompressFormat.heic;
    default:
      return CompressFormat.jpeg;
  }
}

/// Placeholder for PDF compression (currently returns same file)
Future<File> compressPdfFile(File pdfFile) async {
  // Implement real PDF compression if needed using native channels or external libraries
  return pdfFile;
}

/// Check file size in readable format (KB or MB)
String getFileSize(File file) {
  try {
    final bytes = file.lengthSync();
    final kb = bytes / 1024;
    final mb = kb / 1024;
    return mb >= 1
        ? "${mb.toStringAsFixed(2)} MB"
        : "${kb.toStringAsFixed(2)} KB";
  } catch (e) {
    return "0 KB";
  }
}