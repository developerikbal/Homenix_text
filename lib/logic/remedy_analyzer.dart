import 'package:homeonix/data/remedy_data.dart';
import 'package:homeonix/models/symptom_model.dart';
import 'package:homeonix/models/remedy_model.dart';

class RemedyAnalyzer {
  /// Takes a list of symptoms and returns a list of suggested remedies ranked by match count.
  List<RemedyMatch> analyzeSymptoms(List<String> inputSymptoms) {
    Map<String, int> remedyScores = {};

    for (String symptom in inputSymptoms) {
      final matchedEntries = remedyDatabase.entries.where((entry) {
        return entry.value.symptoms.contains(symptom.toLowerCase().trim());
      });

      for (var match in matchedEntries) {
        remedyScores[match.key] = (remedyScores[match.key] ?? 0) + 1;
      }
    }

    List<RemedyMatch> rankedResults = remedyScores.entries
        .map((entry) => RemedyMatch(
              remedy: remedyDatabase[entry.key]!,
              matchScore: entry.value,
            ))
        .toList();

    rankedResults.sort((a, b) => b.matchScore.compareTo(a.matchScore));
    return rankedResults;
  }
}

/// Result wrapper for each remedy with match score
class RemedyMatch {
  final RemedyModel remedy;
  final int matchScore;

  RemedyMatch({required this.remedy, required this.matchScore});
}