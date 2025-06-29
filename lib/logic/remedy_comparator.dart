// lib/logic/remedy_comparator.dart

import '../models/remedy_model.dart';

class RemedyComparator {
  /// Compare two remedies and return a map of differences.
  /// Each key is the property name and the value is a list [remedy1, remedy2]
  static Map<String, List<dynamic>> compareRemedies(
    RemedyModel remedy1,
    RemedyModel remedy2,
  ) {
    final Map<String, List<dynamic>> differences = {};

    if (remedy1.name != remedy2.name) {
      differences['name'] = [remedy1.name, remedy2.name];
    }

    if (remedy1.potency != remedy2.potency) {
      differences['potency'] = [remedy1.potency, remedy2.potency];
    }

    if (remedy1.source != remedy2.source) {
      differences['source'] = [remedy1.source, remedy2.source];
    }

    if (remedy1.symptoms.length != remedy2.symptoms.length ||
        !remedy1.symptoms.toSet().containsAll(remedy2.symptoms)) {
      differences['symptoms'] = [remedy1.symptoms, remedy2.symptoms];
    }

    if (remedy1.keynotes.length != remedy2.keynotes.length ||
        !remedy1.keynotes.toSet().containsAll(remedy2.keynotes)) {
      differences['keynotes'] = [remedy1.keynotes, remedy2.keynotes];
    }

    if (remedy1.relationships != remedy2.relationships) {
      differences['relationships'] = [remedy1.relationships, remedy2.relationships];
    }

    if (remedy1.miasm != remedy2.miasm) {
      differences['miasm'] = [remedy1.miasm, remedy2.miasm];
    }

    return differences;
  }

  /// Utility method to check similarity score (0 to 1)
  static double calculateSimilarity(RemedyModel a, RemedyModel b) {
    int matched = 0;
    int total = 0;

    if (a.name == b.name) matched++;
    total++;

    if (a.potency == b.potency) matched++;
    total++;

    if (a.source == b.source) matched++;
    total++;

    if (a.symptoms.toSet().intersection(b.symptoms.toSet()).isNotEmpty) matched++;
    total++;

    if (a.keynotes.toSet().intersection(b.keynotes.toSet()).isNotEmpty) matched++;
    total++;

    if (a.miasm == b.miasm) matched++;
    total++;

    return total > 0 ? matched / total : 0;
  }
}