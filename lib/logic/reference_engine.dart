import 'package:homeonix/data/book_index.dart';
import 'package:homeonix/models/remedy_model.dart';
import 'package:homeonix/models/symptom_model.dart';

class ReferenceEngine {
  final List<Symptom> userSymptoms;

  ReferenceEngine({required this.userSymptoms});

  /// মূল কার্যক্রম: রেফারেন্স বইগুলো থেকে মিলিয়ে রেমেডি সাজেস্ট করা
  List<RemedyScore> analyze() {
    final Map<String, RemedyScore> remedyScores = {};

    for (final symptom in userSymptoms) {
      final symptomText = symptom.name.toLowerCase().trim();

      if (bookIndex.containsKey(symptomText)) {
        final List<String> matchedRemedies = bookIndex[symptomText]!;

        for (final remedyName in matchedRemedies) {
          final normalized = remedyName.toLowerCase().trim();

          if (!remedyScores.containsKey(normalized)) {
            remedyScores[normalized] = RemedyScore(name: normalized, score: 0);
          }

          remedyScores[normalized]!.score += 1;
        }
      }
    }

    final result = remedyScores.values.toList();
    result.sort((a, b) => b.score.compareTo(a.score)); // descending order
    return result;
  }
}

/// RemedyScore: Remedy নাম ও স্কোরের মডেল
class RemedyScore {
  final String name;
  int score;

  RemedyScore({required this.name, required this.score});
}