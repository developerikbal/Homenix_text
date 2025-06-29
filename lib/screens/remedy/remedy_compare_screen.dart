// lib/screens/remedy/remedy_compare_screen.dart

import 'package:flutter/material.dart';
import 'package:homeonix/models/remedy_model.dart';
import 'package:homeonix/widgets/remedy_card.dart';

class RemedyCompareScreen extends StatelessWidget {
  final Remedy remedy1;
  final Remedy remedy2;

  const RemedyCompareScreen({
    Key? key,
    required this.remedy1,
    required this.remedy2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Remedies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(child: RemedyDetailCard(remedy: remedy1)),
                  const SizedBox(width: 12),
                  Expanded(child: RemedyDetailCard(remedy: remedy2)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class RemedyDetailCard extends StatelessWidget {
  final Remedy remedy;

  const RemedyDetailCard({Key? key, required this.remedy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(remedy.name,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 10),
            if (remedy.keynote != null)
              Text(
                'Keynotes:\n${remedy.keynote}',
                style: textTheme.bodyMedium,
              ),
            const SizedBox(height: 8),
            if (remedy.symptoms.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: remedy.symptoms.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        '• ${remedy.symptoms[index]}',
                        style: textTheme.bodySmall,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}