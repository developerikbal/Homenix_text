// lib/logic/remedy_differentiator.dart

import '../models/remedy_model.dart';
import '../models/symptom_model.dart';

/// RemedyDifferentiator class helps to analyze and differentiate between multiple remedies
/// based on symptom similarity, grade, keynote match, and modal alignment.
class RemedyDifferentiator {
  /// Takes a list of remedies and symptoms, returns a sorted list based on best match.
  List<RemedyModel> differentiate({
    required List<RemedyModel> remedies,
    required List<SymptomModel> inputSymptoms,
  }) {
    // Each remedy will be scored based on matching logic
    final Map<RemedyModel, double> remedyScores = {};

    for (final remedy in remedies) {
      double score = 0;

      for (final symptom in inputSymptoms) {
        if (_matchesSymptom(remedy, symptom)) {
          score += _symptomWeight(symptom);
        }
      }

      // Add grade weight
      score += remedy.grade.toDouble() * 0.5;

      // Add keynote match
      if (_matchesKeynote(remedy, inputSymptoms)) {
        score += 2.0;
      }

      remedyScores[remedy] = score;
    }

    // Sort remedies by score descending
    final sortedRemedies = remedyScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedRemedies.map((e) => e.key).toList();
  }

  /// Returns true if the remedy matches the given symptom
  bool _matchesSymptom(RemedyModel remedy, SymptomModel symptom) {
    return remedy.symptoms.any((rSymptom) =>
      rSymptom.name.toLowerCase().contains(symptom.name.toLowerCase()));
  }

  /// Assigns weight to symptom based on importance
  double _symptomWeight(SymptomModel symptom) {
    switch (symptom.type) {
      case SymptomType.mental:
        return 2.0;
      case SymptomType.general:
        return 1.5;
      case SymptomType.particular:
        return 1.0;
      default:
        return 1.0;
    }
  }

  /// Checks if remedy matches any keynote symptom
  bool _matchesKeynote(RemedyModel remedy, List<SymptomModel> inputSymptoms) {
    for (final keynote in remedy.keynotes) {
      for (final symptom in inputSymptoms) {
        if (keynote.toLowerCase().contains(symptom.name.toLowerCase())) {
          return true;
        }
      }
    }
    return false;
  }
}