// File: lib/data/loaders/remedy_loader.dart

import 'dart:convert';
import 'package:flutter/services.dart';
import '../../models/remedy_model.dart';

/// RemedyLoader class responsible for loading and parsing remedy JSON data.
class RemedyLoader {
  static final RemedyLoader _instance = RemedyLoader._internal();

  factory RemedyLoader() {
    return _instance;
  }

  RemedyLoader._internal();

  List<RemedyModel> _remedies = [];

  /// Load remedies from local JSON file
  Future<void> loadRemediesFromJson() async {
    if (_remedies.isNotEmpty) return;

    try {
      final String jsonString =
          await rootBundle.loadString('assets/books/translated_json/remedies.json');
      final List<dynamic> jsonList = jsonDecode(jsonString);
      _remedies = jsonList.map((json) => RemedyModel.fromJson(json)).toList();
    } catch (e) {
      print('Error loading remedies: $e');
      _remedies = [];
    }
  }

  /// Get all loaded remedies
  List<RemedyModel> getAllRemedies() {
    return _remedies;
  }

  /// Find remedy by exact name
  RemedyModel? findByName(String name) {
    try {
      return _remedies.firstWhere(
        (remedy) => remedy.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  /// Filter remedies by a single symptom keyword
  List<RemedyModel> filterBySymptom(String keyword) {
    return _remedies.where((remedy) {
      return remedy.symptoms.any(
          (symptom) => symptom.toLowerCase().contains(keyword.toLowerCase()));
    }).toList();
  }

  /// Search remedies by multiple symptom keywords
  List<RemedyModel> searchBySymptoms(List<String> keywords) {
    return _remedies.where((remedy) {
      return keywords.every((key) => remedy.symptoms.any(
          (symptom) => symptom.toLowerCase().contains(key.toLowerCase())));
    }).toList();
  }
}