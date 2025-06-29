import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a patient-entered or detected symptom in the system.
class SymptomModel {
  /// Unique ID for the symptom (can be Firestore doc ID or generated)
  final String id;

  /// Main symptom text as entered or parsed (can be Bengali/English)
  final String description;

  /// Severity level (1-10) or priority rank for remedy matching
  final int intensity;

  /// Symptom category (e.g., "Mind", "Head", "Abdomen", etc.)
  final String category;

  /// Source: manual, voice, image, QR, OCR, etc.
  final String source;

  /// Timestamp when the symptom was added
  final DateTime createdAt;

  /// Rubrics mapped from repertory books
  final List<String> rubrics;

  /// Whether this symptom was extracted automatically
  final bool isExtracted;

  SymptomModel({
    required this.id,
    required this.description,
    required this.intensity,
    required this.category,
    required this.source,
    required this.createdAt,
    this.rubrics = const [],
    this.isExtracted = false,
  });

  /// Convert SymptomModel to a map for Firebase storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'intensity': intensity,
      'category': category,
      'source': source,
      'createdAt': Timestamp.fromDate(createdAt),
      'rubrics': rubrics,
      'isExtracted': isExtracted,
    };
  }

  /// Create SymptomModel from Firestore data
  factory SymptomModel.fromJson(Map<String, dynamic> json) {
    return SymptomModel(
      id: json['id'] ?? '',
      description: json['description'] ?? '',
      intensity: json['intensity'] ?? 1,
      category: json['category'] ?? 'General',
      source: json['source'] ?? 'manual',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      rubrics: List<String>.from(json['rubrics'] ?? []),
      isExtracted: json['isExtracted'] ?? false,
    );
  }
}