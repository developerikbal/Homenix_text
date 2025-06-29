import 'package:flutter/material.dart';
import 'package:homeonix/models/remedy_model.dart';
import 'package:homeonix/core/constants.dart';
import 'package:homeonix/widgets/custom_textfield.dart'; // Optional: Remove if not used
import 'package:homeonix/widgets/section_divider.dart';  // Optional: Remove if not used
import 'package:homeonix/services/remedy_service.dart';  // Optional: Remove if not used

class RemedyDetailScreen extends StatelessWidget {
  final RemedyModel remedy;

  const RemedyDetailScreen({super.key, required this.remedy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          remedy.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Remedy Name
            Text(
              remedy.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),

            // Botanical/Latin Name (optional)
            if (remedy.latinName != null && remedy.latinName!.trim().isNotEmpty)
              Text(
                'Botanical: ${remedy.latinName}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),

            const SizedBox(height: 16),
            const Divider(),

            // Indications
            Text(
              "Indications",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              remedy.indications?.trim().isNotEmpty == true
                  ? remedy.indications!
                  : 'No indications found.',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 24),

            // Modalities
            if (remedy.modalities != null && remedy.modalities!.trim().isNotEmpty) ...[
              Text(
                "Modalities",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                remedy.modalities!,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
            ],

            // Relationships
            if (remedy.relationships != null && remedy.relationships!.trim().isNotEmpty) ...[
              Text(
                "Relationships",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                remedy.relationships!,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
            ],

            // Source Reference (optional)
            if (remedy.source != null && remedy.source!.trim().isNotEmpty)
              Text(
                "Source: ${remedy.source}",
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}