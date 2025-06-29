// 🔍 TEST: Remedy Analyzer, Symptom Matcher, Grade Suggester
// Structure: Each function points to where its logic exists in /lib directory

import 'package:flutter_test/flutter_test.dart';
import 'package:homeonix/logic/remedy_analyzer.dart';          // ✅ Logic path
import 'package:homeonix/logic/symptom_matcher.dart';          // ✅ Logic path
import 'package:homeonix/logic/grade_suggester.dart';          // ✅ Logic path
import 'package:homeonix/models/remedy_model.dart';            // ✅ Model path

void main() {
  group('Remedy Analyzer Test', () {
    test('should return matching remedies for symptoms', () {
      // Path: lib/logic/remedy_analyzer.dart
      final symptoms = ['fear', 'sleeplessness'];
      final result = RemedyAnalyzer.analyze(symptoms);

      expect(result, isNotEmpty);
      expect(result.first.name, isA<String>());
    });
  });

  group('Symptom Matcher Test', () {
    test('should map input to rubrics correctly', () {
      // Path: lib/logic/symptom_matcher.dart
      final input = 'burning urination';
      final mappedRubric = SymptomMatcher.mapToRubric(input);

      expect(mappedRubric, isNotNull);
      expect(mappedRubric.rubric, contains('Urination, burning'));
    });
  });

  group('Grade Suggester Test', () {
    test('should suggest proper grade for remedy', () {
      // Path: lib/logic/grade_suggester.dart
      final remedy = RemedyModel(name: 'Arsenicum', grade: 2);
      final upgraded = GradeSuggester.suggest(remedy, context: ['anxiety', 'restlessness']);

      expect(upgraded.grade, greaterThanOrEqualTo(2));
    });
  });
}