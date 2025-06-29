// lib/screens/remedy/remedy_result_screen.dart

import 'package:flutter/material.dart';
import 'package:homeonix/models/remedy_model.dart';
import 'package:homeonix/widgets/remedy_card.dart';
import 'package:homeonix/controllers/remedy_controller.dart';
import 'package:get/get.dart';

class RemedyResultScreen extends StatelessWidget {
  final List<String> symptoms;

  const RemedyResultScreen({super.key, required this.symptoms});

  @override
  Widget build(BuildContext context) {
    final RemedyController remedyController = Get.put(RemedyController());

    // রেমেডি বিশ্লেষণ শুরু
    remedyController.analyzeSymptoms(symptoms);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggested Remedies'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (remedyController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (remedyController.suggestedRemedies.isEmpty) {
          return const Center(child: Text('No remedy found for given symptoms.'));
        }

        return ListView.builder(
          itemCount: remedyController.suggestedRemedies.length,
          itemBuilder: (context, index) {
            final RemedyModel remedy = remedyController.suggestedRemedies[index];
            return RemedyCard(remedy: remedy);
          },
        );
      }),
    );
  }
}