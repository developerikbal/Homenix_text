import 'relationship_model.dart';

/// RemedyModel: একটি হোমিওপ্যাথিক ঔষধের পূর্ণাঙ্গ তথ্য ধারণ করার মডেল ক্লাস

enum RemedyBadgeType { acute, chronic, polychrest }

class RemedyModel {
  final String id;
  final String name;
  final String potency;
  final int grade;
  final String keynote;
  final List<String> symptoms;
  final List<String>? complementary;
  final List<String>? inimical;
  final String? source;
  final DateTime createdAt;
  final RemedyBadgeType badgeType;

  /// নতুন যুক্ত ফিল্ড
  final List<RelationshipModel> relationships;

  /// *** ADD THESE FIELDS FOR FULL FEATURE SUPPORT ***
  /// (If you want to add keySymptoms, modalities, mentalSymptoms, physicalSymptoms, potencySuggestion)
  final List<String>? keySymptoms;
  final List<String>? modalities;
  final List<String>? mentalSymptoms;
  final List<String>? physicalSymptoms;
  final String? potencySuggestion;

  RemedyModel({
    required this.id,
    required this.name,
    required this.potency,
    required this.grade,
    required this.keynote,
    required this.symptoms,
    this.complementary,
    this.inimical,
    this.source,
    required this.createdAt,
    required this.badgeType,
    this.relationships = const [],
    this.keySymptoms,
    this.modalities,
    this.mentalSymptoms,
    this.physicalSymptoms,
    this.potencySuggestion,
  });

  factory RemedyModel.fromJson(Map<String, dynamic> json) {
    return RemedyModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      potency: json['potency'] ?? '',
      grade: json['grade'] ?? 0,
      keynote: json['keynote'] ?? '',
      symptoms: List<String>.from(json['symptoms'] ?? []),
      complementary: json['complementary'] != null
          ? List<String>.from(json['complementary'])
          : null,
      inimical: json['inimical'] != null
          ? List<String>.from(json['inimical'])
          : null,
      source: json['source'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      badgeType: _parseBadgeType(json['badgeType']),
      relationships: (json['relationships'] as List<dynamic>?)
              ?.map((e) => RelationshipModel.fromJson(e))
              .toList() ??
          [],
      keySymptoms: json['keySymptoms'] != null
          ? List<String>.from(json['keySymptoms'])
          : null,
      modalities: json['modalities'] != null
          ? List<String>.from(json['modalities'])
          : null,
      mentalSymptoms: json['mentalSymptoms'] != null
          ? List<String>.from(json['mentalSymptoms'])
          : null,
      physicalSymptoms: json['physicalSymptoms'] != null
          ? List<String>.from(json['physicalSymptoms'])
          : null,
      potencySuggestion: json['potencySuggestion'],
    );
  }

  static RemedyBadgeType _parseBadgeType(String? value) {
    switch (value) {
      case 'acute':
        return RemedyBadgeType.acute;
      case 'chronic':
        return RemedyBadgeType.chronic;
      case 'polychrest':
        return RemedyBadgeType.polychrest;
      default:
        return RemedyBadgeType.acute;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'potency': potency,
      'grade': grade,
      'keynote': keynote,
      'symptoms': symptoms,
      'complementary': complementary,
      'inimical': inimical,
      'source': source,
      'createdAt': createdAt.toIso8601String(),
      'badgeType': badgeType.name,
      'relationships': relationships.map((r) => r.toJson()).toList(),
      'keySymptoms': keySymptoms,
      'modalities': modalities,
      'mentalSymptoms': mentalSymptoms,
      'physicalSymptoms': physicalSymptoms,
      'potencySuggestion': potencySuggestion,
    };
  }
}
