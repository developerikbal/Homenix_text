import 'dart:convert';
import 'package:flutter/services.dart';
import '../data/rubric_map.dart';
import '../models/remedy_model.dart';

class SymptomAnalyzer {
  Map<String, dynamic> _rubricMap = {};
  Map<String, List<String>> _remedySuggestions = {};

  // Load rubric data from JSON or static Dart file
  Future<void> loadRubricMap() async {
    try {
      final rubricData = await rootBundle.loadString('assets/books/translated_json/rubric_map.json');
      _rubricMap = json.decode(rubricData);
    } catch (e) {
      print("Error loading rubric data: $e");
    }
  }

  // Analyze user input and return matched rubrics and remedy suggestions
  Future<Map<String, dynamic>> analyzeSymptoms(String inputText, {String language = 'en'}) async {
    if (_rubricMap.isEmpty) {
      await loadRubricMap();
    }

    final normalizedText = _normalizeInput(inputText, language);
    final matchedRubrics = _matchRubrics(normalizedText);
    final remedies = _suggestRemedies(matchedRubrics);

    return {
      'matchedRubrics': matchedRubrics,
      'suggestedRemedies': remedies,
    };
  }

  // Normalize user input text
  String _normalizeInput(String text, String lang) {
    String normalized = text.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '').trim();
    return lang == 'bn' ? _translateBanglaToEnglish(normalized) : normalized;
  }

  // Basic Bengali to English term translation
  String _translateBanglaToEnglish(String input) {
    Map<String, String> bnToEn = {
      "": "headache",
      "": "fear",
      "": "sweat",
      "": "hunger",
      "": "anger",
      "": "anxiety",
      "": "sleep",
      "": "vomit",
      "": "pain",
      "": "fever",
      "": "depression",
    };

    bnToEn.forEach((bn, en) {
      input = input.replaceAll(bn, en);
    });

    return input;
  }

  // Match rubrics based on input
  List<String> _matchRubrics(String normalizedInput) {
    List<String> matched = [];

    _rubricMap.forEach((rubric, data) {
      final synonyms = List<String>.from(data['synonyms'] ?? []);
      for (var synonym in synonyms) {
        if (normalizedInput.contains(synonym.toLowerCase())) {
          matched.add(rubric);
          break;
        }
      }
    });

    return matched;
  }

  // Suggest remedies based on matched rubrics
  Map<String, int> _suggestRemedies(List<String> matchedRubrics) {
    Map<String, int> remedyScores = {};

    for (var rubric in matchedRubrics) {
      final remedies = List<String>.from(_rubricMap[rubric]?['remedies'] ?? []);

      for (var remedy in remedies) {
        if (remedyScores.containsKey(remedy)) {
          remedyScores[remedy] = remedyScores[remedy]! + 1;
        } else {
          remedyScores[remedy] = 1;
        }
      }
    }

    final sorted = Map.fromEntries(
      remedyScores.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value)),
    );

    return sorted;
  }
}