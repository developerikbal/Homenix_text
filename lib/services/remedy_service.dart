import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/remedy_model.dart';

/// RemedyService - Responsible for loading and analyzing remedy data.
class RemedyService {
  static List<RemedyModel> _remedies = [];

  /// Load data from local JSON
  static Future<void> loadRemedies() async {
    final String jsonString = await rootBundle.loadString('assets/books/translated_json/remedies.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    _remedies = jsonData.map((json) => RemedyModel.fromJson(json)).toList();
  }

  /// Return all remedies
  static List<RemedyModel> getAllRemedies() => _remedies;

  /// Search by input symptom
  static List<RemedyModel> searchBySymptoms(String inputSymptom) {
    final lowerInput = inputSymptom.toLowerCase();
    return _remedies.where((remedy) {
      return remedy.symptoms.any((symptom) => symptom.toLowerCase().contains(lowerInput));
    }).toList();
  }

  /// Find by ID
  static RemedyModel? getRemedyById(String id) {
    try {
      return _remedies.firstWhere((remedy) => remedy.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Compare two remedies
  static Map<String, dynamic> compareRemedies(String id1, String id2) {
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

  /// Developer Methods
  static Future<void> addRemedy(RemedyModel remedy) async {
    // Optional: implement write-back to Firebase or local DB
    _remedies.add(remedy);
  }

  static Future<void> updateRemedy(RemedyModel remedy) async {
    // Optional: update data source
    final index = _remedies.indexWhere((r) => r.id == remedy.id);
    if (index != -1) {
      _remedies[index] = remedy;
    }
  }

  static Future<void> deleteRemedy(String remedyId) async {
    _remedies.removeWhere((r) => r.id == remedyId);
  }
}
