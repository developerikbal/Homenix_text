// File: lib/logic/symptom_matcher.dart

import '../data/remedy_data.dart';
import '../models/symptom_model.dart';
import '../models/remedy_model.dart';

class SymptomMatcher {
  /// Match symptoms with remedies and return a list of suggestions with score
  static List<RemedyMatchResult> matchSymptoms(List<Symptom> inputSymptoms) {
    final List<RemedyMatchResult> results = [];

    for (final remedy in remedyList) {
      int matchScore = 0;
      List<String> matchedSymptoms = [];

      for (final inputSymptom in inputSymptoms) {
        for (final remedySymptom in remedy.symptoms) {
          if (_normalize(remedySymptom)
              .contains(_normalize(inputSymptom.name))) {
            matchScore++;
            matchedSymptoms.add(remedySymptom);
            break;
          }
        }
      }

      if (matchScore > 0) {
        results.add(RemedyMatchResult(
          remedy: remedy,
          score: matchScore,
          matchedSymptoms: matchedSymptoms,
        ));
      }
    }

    results.sort((a, b) => b.score.compareTo(a.score));
    return results;
  }

  /// Normalize symptom text to lowercase and trimmed
  static String _normalize(String text) {
    return text.toLowerCase().trim();
  }
}

class RemedyMatchResult {
  final Remedy remedy;
  final int score;
  final List<String> matchedSymptoms;

  RemedyMatchResult({
    required this.remedy,
    required this.score,
    required this.matchedSymptoms,
  });
}