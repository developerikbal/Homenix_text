// lib/models/remedy_model.dart

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
    };
  }
}
