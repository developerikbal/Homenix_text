import '../models/remedy_model.dart';

// Helper function to generate a unique id for each remedy
String _generateId(String name, int idx) => '${name.toLowerCase()}_$idx';

// Helper function to convert relationship Map<String, List<String>>
// to List<RelationshipModel>
List<RelationshipModel> toRelationshipList(Map<String, List<String>> map) {
  final List<RelationshipModel> res = [];
  map.forEach((type, names) {
    for (final remedy in names) {
      res.add(RelationshipModel(type: type, remedy: remedy));
    }
  });
  return res;
}

final List<RemedyModel> remedyList = [
  RemedyModel(
    id: _generateId('Aconite', 0),
    name: 'Aconite',
    keynote: 'Sudden onset of intense fear, anxiety, and high fever after exposure to cold, dry wind.',
    grade: 1,
    badgeType: RemedyBadgeType.acute,
    createdAt: DateTime(2024, 7, 1),
    potency: '30C/200C',
    symptoms: [
      'Sudden onset of symptoms',
      'High fever with restlessness',
      'Dry, burning heat',
      'Thirst for cold drinks',
      'Red, hot face',
      'Worse at night',
      'Worse from cold, dry wind',
      'Fear and anxiety',
      'Fear of death',
      'Restless and anxious',
    ],
    keySymptoms: [
      'Sudden onset of symptoms',
      'Fear and anxiety',
      'High fever with restlessness',
    ],
    modalities: [
      'Worse at night',
      'Worse from cold, dry wind',
    ],
    mentalSymptoms: [
      'Fear of death',
      'Restless and anxious',
    ],
    physicalSymptoms: [
      'Dry, burning heat',
      'Thirst for cold drinks',
      'Red, hot face',
    ],
    potencySuggestion: '30C for acute; 200C in intense mental state',
    relationships: toRelationshipList({
      'Complementary': ['Belladonna'],
      'Inimical': ['Sulphur'],
    }),
  ),
  RemedyModel(
    id: _generateId('Bryonia', 1),
    name: 'Bryonia',
    keynote: 'Dryness, great thirst, and aggravation from the slightest motion.',
    grade: 1,
    badgeType: RemedyBadgeType.chronic,
    createdAt: DateTime(2024, 7, 1),
    potency: '30C-200C',
    symptoms: [
      'Dryness of all membranes',
      'Great thirst for large quantities of water',
      'Worse from slightest motion',
      'Better from rest',
      'Worse in the morning',
      'Irritable',
      'Wants to be left alone',
      'Headache over forehead',
      'Dry, hacking cough',
      'Stitching pain in chest',
    ],
    keySymptoms: [
      'Dryness of all membranes',
      'Great thirst for large quantities of water',
      'Worse from slightest motion',
    ],
    modalities: [
      'Better from rest',
      'Worse from motion',
      'Worse in the morning',
    ],
    mentalSymptoms: [
      'Irritable',
      'Wants to be left alone',
    ],
    physicalSymptoms: [
      'Headache over forehead',
      'Dry, hacking cough',
      'Stitching pain in chest',
    ],
    potencySuggestion: '30C to 200C depending on intensity',
    relationships: toRelationshipList({
      'Complementary': ['Rhus Toxicodendron'],
      'Inimical': ['Pulsatilla'],
    }),
  ),
  RemedyModel(
    id: _generateId('Arsenicum Album', 2),
    name: 'Arsenicum Album',
    keynote: 'Great weakness, burning pains, and anxiety about health.',
    grade: 1,
    badgeType: RemedyBadgeType.acute,
    createdAt: DateTime(2024, 7, 1),
    potency: '6C/30C/200C',
    symptoms: [
      'Great weakness and restlessness',
      'Burning pains',
      'Anxiety about health',
      'Better with warmth',
      'Worse after midnight',
      'Fear of being alone',
      'Anxiety and restlessness',
      'Vomiting and diarrhea',
      'Burning sensation in chest or stomach',
    ],
    keySymptoms: [
      'Great weakness and restlessness',
      'Burning pains',
      'Anxiety about health',
    ],
    modalities: [
      'Better with warmth',
      'Worse after midnight',
    ],
    mentalSymptoms: [
      'Fear of being alone',
      'Anxiety and restlessness',
    ],
    physicalSymptoms: [
      'Vomiting and diarrhea',
      'Burning sensation in chest or stomach',
    ],
    potencySuggestion: '6C, 30C or 200C depending on case',
    relationships: toRelationshipList({
      'Complementary': ['Phosphorus'],
      'Inimical': ['Nux Vomica'],
    }),
  ),
];
