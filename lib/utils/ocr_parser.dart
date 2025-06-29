/// File: lib/utils/ocr_parser.dart
/// Description: This utility handles OCR text input, parses it,
///              and converts it into usable symptom/rubric data
///              for Homeonix Remedy Analysis System.

import 'dart:convert';
import 'package:flutter/services.dart';
import '../logic/symptom_matcher.dart'; // Handles advanced symptom keyword matching
import '../data/rubric_map.dart'; // Contains symptom-to-keyword mapping
import '../models/symptom_model.dart'; // SymptomModel class definition

class OCRParser {
  /// Cleans the raw OCR text and removes unwanted characters.
  /// Suggested Move If Needed: lib/utils/text_cleaner.dart
  static String cleanText(String rawText) {
    return rawText
        .replaceAll(RegExp(r'\n+'), ' ') // remove new lines
        .replaceAll(RegExp(r'[^\w\s,.-]'), '') // remove special chars
        .toLowerCase()
        .trim();
  }

  /// Takes cleaned text and identifies probable symptoms from rubric map.
  /// Suggested Move If Needed: lib/logic/symptom_extractor.dart
  static List<String> extractSymptoms(String cleanedText) {
    List<String> matchedSymptoms = [];

    rubricMap.forEach((symptom, keywords) {
      for (String keyword in keywords) {
        if (cleanedText.contains(keyword.toLowerCase())) {
          matchedSymptoms.add(symptom);
          break;
        }
      }
    });

    return matchedSymptoms;
  }

  /// Converts symptom strings into usable `SymptomModel` objects for UI
  /// Suggested Move If Needed: lib/models/symptom_factory.dart
  static List<SymptomModel> convertToSymptomObjects(List<String> symptomStrings) {
    return symptomStrings
        .map((s) => SymptomModel(name: s, intensity: 'moderate')) // default intensity
        .toList();
  }

  /// Full pipeline function to process raw OCR text to symptom model list.
  /// Call this from image_analysis_service or dev panel.
  /// Suggested Call Point: lib/services/image_analysis_service.dart
  static List<SymptomModel> parseOCR(String rawText) {
    final cleaned = cleanText(rawText);
    final extracted = extractSymptoms(cleaned);
    return convertToSymptomObjects(extracted);
  }
}