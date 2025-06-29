// lib/services/remedy_service.dart

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:homeonix/models/remedy_model.dart';

/// RemedyService - Responsible for loading and analyzing remedy data.
class RemedyService {
  List<RemedyModel> _remedies = [];

  /// Loads remedy data from a local JSON file.
  Future<void> loadRemedies() async {
    final String jsonString = await rootBundle.loadString('assets/books/translated_json/remedies.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    _remedies = jsonData.map((json) => RemedyModel.fromJson(json)).toList();
  }

  /// Returns all remedies
  List<RemedyModel> getAllRemedies() => _remedies;

  /// Searches for remedies that match a given symptom
  List<RemedyModel> searchBySymptoms(String inputSymptom) {
    final lowerInput = inputSymptom.toLowerCase();
    return _remedies.where((remedy) {
      return remedy.symptoms.any((symptom) => symptom.toLowerCase().contains(lowerInput));
    }).toList();
  }

  /// Returns remedy by ID
  RemedyModel? getRemedyById(String id) {
    try {
      return _remedies.firstWhere((remedy) => remedy.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Compares two remedies based on their symptoms
  Map<String, dynamic> compareRemedies(String id1, String id2) {
    final r1 = getRemedyById(id1);
    final r2 = getRemedyById(id2);

    if (r1 == null || r2 == null) {
      return {"error": "One or both remedies not found"};
    }

    final commonSymptoms = r1.symptoms.toSet().intersection(r2.symptoms.toSet()).toList();
    final uniqueToR1 = r1.symptoms.toSet().difference(r2.symptoms.toSet()).toList();
    final uniqueToR2 = r2.symptoms.toSet().difference(r1.symptoms.toSet()).toList();

    return {
      "common": commonSymptoms,
      "only_in_${r1.id}": uniqueToR1,
      "only_in_${r2.id}": uniqueToR2,
    };
  }
}