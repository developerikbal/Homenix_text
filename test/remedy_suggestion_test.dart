// File: homeonix/test/remedy_suggestion_test.dart
// Purpose: To test the core remedy suggestion logic from symptom input.

// ✅ Related logic file path:
// See: lib/logic/remedy_analyzer.dart
// See: lib/logic/symptom_matcher.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:homeonix/logic/remedy_analyzer.dart';
import 'package:homeonix/logic/symptom_matcher.dart';
import 'package:homeonix/data/remedy_data.dart'; // Mock remedies

void main() {
  group('Remedy Suggestion Tests', () {
    test('Basic match with single clear symptom', () {
      // Arrange
      List<String> inputSymptoms = ['burning urination'];

      // Act
      final suggestions = RemedyAnalyzer.getSuggestedRemedies(inputSymptoms);

      // Assert
      expect(suggestions.isNotEmpty, true);
      expect(suggestions.first.name.toLowerCase(), isNotEmpty);
    });

    test('Multiple matching symptoms with remedy priority', () {
      // Arrange
      List<String> inputSymptoms = [
        'fear at night',
        'desire for cold water',
        'burning in chest'
      ];

      // Act
      final suggestions = RemedyAnalyzer.getSuggestedRemedies(inputSymptoms);

      // Assert
      expect(suggestions.length, greaterThan(1));
      expect(suggestions.first.score, greaterThanOrEqualTo(suggestions.last.score));
    });

    test('No match fallback test', () {
      // Arrange
      List<String> inputSymptoms = ['unknown symptom xyz'];

      // Act
      final suggestions = RemedyAnalyzer.getSuggestedRemedies(inputSymptoms);

      // Assert
      expect(suggestions.isEmpty, true);
    });

    test('Partial symptom similarity matching', () {
      // Arrange
      List<String> inputSymptoms = ['burn in urine'];

      // Act
      final suggestions = RemedyAnalyzer.getSuggestedRemedies(inputSymptoms);

      // Assert
      expect(suggestions.isNotEmpty, true);
    });
  });
}