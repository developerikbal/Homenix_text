// lib/data/remedy_data.dart

import '../models/remedy_model.dart';

final List<RemedyModel> remedyList = [
  RemedyModel(
    name: 'Aconite',
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
    relationships: {
      'Complementary': ['Belladonna'],
      'Inimical': ['Sulphur'],
    },
    potencySuggestion: '30C for acute; 200C in intense mental state',
  ),

  RemedyModel(
    name: 'Bryonia',
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
    relationships: {
      'Complementary': ['Rhus Toxicodendron'],
      'Inimical': ['Pulsatilla'],
    },
    potencySuggestion: '30C to 200C depending on intensity',
  ),

  RemedyModel(
    name: 'Arsenicum Album',
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
    relationships: {
      'Complementary': ['Phosphorus'],
      'Inimical': ['Nux Vomica'],
    },
    potencySuggestion: '6C, 30C or 200C depending on case',
  ),
];