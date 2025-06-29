import 'dart:io';
import 'package:pdf_text/pdf_text.dart';

/// Function: Extract all text from a PDF file
Future<String> extractTextFromPDF(File file) async {
  try {
    final PDFDoc doc = await PDFDoc.fromFile(file);
    return await doc.text;
  } catch (e) {
    print("Error extracting PDF text: $e");
    return '';
  }
}

/// Function: Extract text from a specific page number
Future<String> extractTextFromPage(File file, int pageNumber) async {
  try {
    final PDFDoc doc = await PDFDoc.fromFile(file);
    if (pageNumber < 1 || pageNumber > doc.length) {
      print("Invalid page number: $pageNumber");
      return '';
    }
    final page = await doc.pageAt(pageNumber);
    return await page.text;
  } catch (e) {
    print("Error extracting text from page $pageNumber: $e");
    return '';
  }
}

/// Function: Extract all pages as a list of strings
Future<List<String>> extractPagesAsList(File file) async {
  List<String> pages = [];
  try {
    final PDFDoc doc = await PDFDoc.fromFile(file);
    for (int i = 1; i <= doc.length; i++) {
      final page = await doc.pageAt(i);
      final pageText = await page.text;
      pages.add(pageText);
    }
  } catch (e) {
    print("Error extracting pages: $e");
  }
  return pages;
}