import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:homeonix/services/ocr_translate.dart';
import 'package:homeonix/services/symptom_analyzer.dart';

class ImageProcessor {
  // 1. Load image file from device and convert to img.Image
  static Future<img.Image?> loadImage(File file) async {
    try {
      final bytes = await file.readAsBytes();
      return img.decodeImage(bytes);
    } catch (e) {
      debugPrint('loadImage Error: $e');
      return null;
    }
  }

  // 2. Resize image for faster processing (max 720px wide)
  static img.Image resizeImage(img.Image original) {
    const int maxWidth = 720;
    if (original.width <= maxWidth) return original;
    return img.copyResize(original, width: maxWidth);
  }

  // 3. Convert resized image to byte data for further processing
  static Uint8List encodeImageToBytes(img.Image image) {
    return Uint8List.fromList(img.encodeJpg(image, quality: 80));
  }

  // 4. Run OCR on the image and extract raw text using Google ML Kit
  static Future<String> extractTextFromImage(File file) async {
    try {
      final inputImage = InputImage.fromFile(file);
      final textRecognizer = GoogleMlKit.vision.textRecognizer();
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      await textRecognizer.close();
      return recognizedText.text;
    } catch (e) {
      debugPrint('extractTextFromImage Error: $e');
      return '';
    }
  }

  // 5. Translate extracted text if needed (e.g., Bengali to English)
  static Future<String> translateIfNeeded(String inputText, String targetLang) async {
    if (targetLang == 'en') {
      return await OcrTranslateService.translateToEnglish(inputText);
    }
    return inputText;
  }

  // 6. Analyze symptoms from translated OCR text
  static Future<List<String>> analyzeSymptoms(String text) async {
    return await SymptomAnalyzer.extractSymptoms(text);
  }

  // 7. Suggest possible remedies based on extracted symptoms
  static Future<List<String>> suggestRemediesFromImage(File file) async {
    try {
      final image = await loadImage(file);
      if (image == null) return [];

      final resized = resizeImage(image);
      final bytes = encodeImageToBytes(resized);
      final tempFile = await _writeTempFile(bytes);

      final rawText = await extractTextFromImage(tempFile);
      if (rawText.isEmpty) return [];

      final translated = await translateIfNeeded(rawText, 'en');
      final symptoms = await analyzeSymptoms(translated);

      return await SymptomAnalyzer.matchRemedies(symptoms);
    } catch (e) {
      debugPrint('suggestRemediesFromImage Error: $e');
      return [];
    }
  }

  // 8. Utility method to write image bytes to temporary file
  static Future<File> _writeTempFile(Uint8List bytes) async {
    final tempDir = Directory.systemTemp;
    final file = File('${tempDir.path}/temp_image.jpg');
    await file.writeAsBytes(bytes);
    return file;
  }
}