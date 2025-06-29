import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

/// Represents a single rubric entry
class RubricEntry {
  final String rubric;
  final List<String> remedies;

  RubricEntry({required this.rubric, required this.remedies});

  factory RubricEntry.fromJson(Map<String, dynamic> json) {
    return RubricEntry(
      rubric: json['rubric'],
      remedies: List<String>.from(json['remedies']),
    );
  }
}

/// Handles searching through loaded rubrics
class RubricSearchEngine {
  final List<RubricEntry> _rubrics = [];

  /// Initialize by loading rubrics from JSON file(s)
  Future<void> loadRubricsFromAssets() async {
    final String data = await rootBundle.loadString('assets/data/rubrics.json');
    final List<dynamic> jsonData = json.decode(data);
    _rubrics.clear();
    _rubrics.addAll(jsonData.map((e) => RubricEntry.fromJson(e)).toList());
  }

  /// Search for rubrics containing the input keyword (partial match allowed)
  List<RubricEntry> search(String keyword) {
    keyword = keyword.trim().toLowerCase();
    return _rubrics.where((entry) {
      return entry.rubric.toLowerCase().contains(keyword);
    }).toList();
  }

  /// Exact match (if needed)
  List<RubricEntry> searchExact(String keyword) {
    keyword = keyword.trim().toLowerCase();
    return _rubrics.where((entry) => entry.rubric.toLowerCase() == keyword).toList();
  }

  /// Bengali and English keyword support
  List<RubricEntry> searchMultilingual(String input) {
    final normalized = _normalize(input);
    return _rubrics.where((entry) {
      final rubric = _normalize(entry.rubric);
      return rubric.contains(normalized);
    }).toList();
  }

  String _normalize(String text) {
    return text
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^\u0980-\u09FFa-zA-Z0-9\s]'), '');
  }
}