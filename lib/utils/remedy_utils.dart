// lib/utils/remedy_utils.dart
// Homeonix Remedy Logic Utility Functions

import '../data/remedy_data.dart';
import '../models/symptom_model.dart';
import '../models/remedy_model.dart';

/// Function: matchSymptomsWithRemedies
/// Matches user input symptoms with remedies in the internal remedy database.
List<RemedyModel> matchSymptomsWithRemedies(List<SymptomModel> symptoms) {
  final List<RemedyModel> matchedRemedies = [];

  for (final remedy in remedyDatabase) {
    int matchCount = 0;

    for (final symptom in symptoms) {
      if (remedy.symptoms.map((s) => s.toLowerCase()).contains(symptom.name.toLowerCase())) {
        matchCount++;
      }
    }

    if (matchCount > 0) {
      final matchScore = matchCount / symptoms.length;
      matchedRemedies.add(remedy.copyWith(matchScore: matchScore));
    }
  }

  // Sort remedies by highest match score
  matchedRemedies.sort((a, b) => b.matchScore.compareTo(a.matchScore));
  return matchedRemedies;
}

/// Function: filterByGrade
/// Filters remedies by a minimum grade threshold.
List<RemedyModel> filterByGrade(List<RemedyModel> remedies, int minGrade) {
  return remedies.where((r) => r.grade >= minGrade).toList();
}

/// Function: highlightTopRemedies
/// Returns top [N] remedies based on match score.
List<RemedyModel> highlightTopRemedies(List<RemedyModel> all, {int top = 3}) {
  return all.take(top).toList();
}

/// Function: explainMatch
/// Creates a human-readable explanation of which symptoms matched.
String explainMatch(RemedyModel remedy, List<SymptomModel> inputSymptoms) {
  final matches = inputSymptoms
      .where((symptom) =>
          remedy.symptoms.map((s) => s.toLowerCase()).contains(symptom.name.toLowerCase()))
      .map((s) => s.name)
      .toList();

  return "Matched Symptoms: ${matches.join(', ')}";
}