// File: homeonix/lib/logic/pdf_processor.dart

import 'dart:io';
import 'package:pdf_text/pdf_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

class PDFProcessor {
  // Extract text from a given PDF file
  static Future<String> extractTextFromPDF(File pdfFile) async {
    try {
      PDFDoc doc = await PDFDoc.fromFile(pdfFile);
      String text = await doc.text;
      return text;
    } catch (e) {
      debugPrint('Error extracting text from PDF: $e');
      return '';
    }
  }

  // Save extracted text to a temporary file
  static Future<File?> saveExtractedTextToFile(String text, String fileName) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileName.txt');
      await file.writeAsString(text);
      return file;
    } catch (e) {
      debugPrint('Error saving text to file: $e');
      return null;
    }
  }

  // Process PDF file and return processed text
  static Future<String> processPDF(File pdfFile) async {
    String extractedText = await extractTextFromPDF(pdfFile);
    String cleanedText = _cleanText(extractedText);
    return cleanedText;
  }

  // Clean unnecessary characters and spaces from the extracted text
  static String _cleanText(String rawText) {
    return rawText
        .replaceAll('\r\n', '\n')
        .replaceAll(RegExp(r'[^\x00-\x7F]'), '') // remove non-ASCII
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}