import 'package:flutter/material.dart';
import '../services/remedy_service.dart';
import '../models/remedy_model.dart';

class RemedyController with ChangeNotifier {
  List<RemedyModel> _allRemedies = [];
  List<RemedyModel> _filteredRemedies = [];
  List<RemedyModel> _suggestedRemedies = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<RemedyModel> get allRemedies => _allRemedies;
  List<RemedyModel> get filteredRemedies => _filteredRemedies;
  List<RemedyModel> get suggestedRemedies => _suggestedRemedies;

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

  void resetFilter() {
    _filteredRemedies = List.from(_allRemedies);
    notifyListeners();
  }

  RemedyModel? getRemedyById(String id) {
    try {
      return _allRemedies.firstWhere((remedy) => remedy.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Developer Features

  Future<void> addNewRemedy(RemedyModel newRemedy) async {
    try {
      await RemedyService.addRemedy(newRemedy);
      _allRemedies.add(newRemedy);
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to add remedy: $e');
    }
  }

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

  Future<void> deleteRemedy(String remedyId) async {
    try {
      await RemedyService.deleteRemedy(remedyId);
      _allRemedies.removeWhere((r) => r.id == remedyId);
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to delete remedy: $e');
    }
  }

  void analyzeSymptoms(String inputText) {
    _suggestedRemedies = RemedyService.searchBySymptoms(inputText);
    notifyListeners();
  }
}
