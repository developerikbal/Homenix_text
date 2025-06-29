import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:homeonix/widgets/custom_textfield.dart';
import 'package:homeonix/widgets/remedy_card.dart';
import 'package:homeonix/services/remedy_service.dart';
import 'package:homeonix/models/remedy_model.dart';
import 'package:homeonix/controllers/language_controller.dart';

class RemedySearchScreen extends StatefulWidget {
  const RemedySearchScreen({super.key});

  @override
  State<RemedySearchScreen> createState() => _RemedySearchScreenState();
}

class _RemedySearchScreenState extends State<RemedySearchScreen> {
  final TextEditingController _symptomController = TextEditingController();
  final RemedyService _remedyService = RemedyService();
  final LanguageController _languageController = Get.put(LanguageController());

  List<RemedyModel> _searchResults = [];
  bool _isLoading = false;
  String _searchLanguage = 'en'; // Default is English, can toggle to 'bn'

  @override
  void dispose() {
    _symptomController.dispose();
    super.dispose();
  }

  Future<void> _onSearchPressed() async {
    final input = _symptomController.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _isLoading = true;
      _searchResults.clear();
    });

    try {
      final List<RemedyModel> remedies = await _remedyService.findRemediesBySymptom(
        input,
        language: _searchLanguage,
      );

      setState(() {
        _searchResults = remedies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Optional: show error using snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching remedies: $e')),
      );
    }
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CustomTextField(
        controller: _symptomController,
        hintText: _searchLanguage == 'en' ? 'Enter symptom (English)' : 'লক্ষণ লিখুন (বাংলা)',
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: _onSearchPressed,
        ),
      ),
    );
  }

  Widget _buildLanguageToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChoiceChip(
          label: const Text("English"),
          selected: _searchLanguage == 'en',
          onSelected: (selected) {
            if (selected) setState(() => _searchLanguage = 'en');
          },
        ),
        const SizedBox(width: 12),
        ChoiceChip(
          label: const Text("বাংলা"),
          selected: _searchLanguage == 'bn',
          onSelected: (selected) {
            if (selected) setState(() => _searchLanguage = 'bn');
          },
        ),
      ],
    );
  }

  Widget _buildResults() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_searchResults.isEmpty) {
      return const Center(child: Text("No remedies found."));
    } else {
      return ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          return RemedyCard(remedy: _searchResults[index]);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_languageController.translate('remedy_search')),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          const SizedBox(height: 10),
          _buildLanguageToggle(),
          const SizedBox(height: 10),
          Expanded(child: _buildResults()),
        ],
      ),
    );
  }
}