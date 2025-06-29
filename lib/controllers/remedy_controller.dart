// Path: lib/controllers/remedy_controller.dart

import 'package:flutter/material.dart';
import '../services/remedy_service.dart';
import '../models/remedy_model.dart';

/// RemedyController manages all remedy operations for Homeonix.
class RemedyController with ChangeNotifier {
  List<RemedyModel> _allRemedies = [];
  List<RemedyModel> _filteredRemedies = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<RemedyModel> get allRemedies => _allRemedies;
  List<RemedyModel> get filteredRemedies => _filteredRemedies;

  /// Fetches all remedies from the database (Firebase/local).
  Future<void> loadAllRemedies() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allRemedies = await RemedyService.fetchAllRemedies();
      _filteredRemedies = List.from(_allRemedies);
    } catch (e) {
      debugPrint('Failed to load remedies: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Filters remedies by symptom keyword.
  void filterRemediesBySymptom(String keyword) {
    if (keyword.trim().isEmpty) {
      _filteredRemedies = List.from(_allRemedies);
    } else {
      _filteredRemedies = _allRemedies.where((remedy) {
        final matchInSymptoms = remedy.symptoms.any(
          (symptom) => symptom.toLowerCase().contains(keyword.toLowerCase()),
        );
        final matchInName = remedy.name.toLowerCase().contains(keyword.toLowerCase());
        return matchInSymptoms || matchInName;
      }).toList();
    }
    notifyListeners();
  }

  /// Resets any active remedy filters.
  void resetFilter() {
    _filteredRemedies = List.from(_allRemedies);
    notifyListeners();
  }

  /// Returns a remedy by its ID.
  RemedyModel? getRemedyById(String id) {
    try {
      return _allRemedies.firstWhere((remedy) => remedy.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Adds a new remedy (Developer mode).
  Future<void> addNewRemedy(RemedyModel newRemedy) async {
    try {
      await RemedyService.addRemedy(newRemedy);
      _allRemedies.add(newRemedy);
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to add remedy: $e');
    }
  }

  /// Updates a remedy (Developer mode).
  Future<void> updateRemedy(RemedyModel updatedRemedy) async {
    try {
      await RemedyService.updateRemedy(updatedRemedy);
      final index = _allRemedies.indexWhere((r) => r.id == updatedRemedy.id);
      if (index != -1) {
        _allRemedies[index] = updatedRemedy;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to update remedy: $e');
    }
  }

  /// Deletes a remedy (Developer mode).
  Future<void> deleteRemedy(String remedyId) async {
    try {
      await RemedyService.deleteRemedy(remedyId);
      _allRemedies.removeWhere((r) => r.id == remedyId);
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to delete remedy: $e');
    }
  }
}