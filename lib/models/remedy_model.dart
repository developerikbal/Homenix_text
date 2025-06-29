// lib/models/remedy_model.dart

/// RemedyModel: একটি হোমিওপ্যাথিক ঔষধের পূর্ণাঙ্গ তথ্য ধারণ করার মডেল ক্লাস

class RemedyModel {
  final String id; // রেমেডির ইউনিক আইডি
  final String name; // রেমেডির নাম (যেমন: Nux Vomica)
  final String potency; // শক্তি (যেমন: 30C)
  final int grade; // গ্রেডিং (যেমন: 3)
  final String keynote; // মূল উপস্থাপন বা সংক্ষিপ্ত উপসর্গ
  final List<String> symptoms; // উপসর্গ তালিকা
  final List<String>? complementary; // সহায়ক রেমেডিগুলি
  final List<String>? inimical; // বিরোধী রেমেডিগুলি
  final String? source; // কোন বই বা সূত্র থেকে
  final DateTime createdAt; // কখন সংযোজন করা হয়েছে

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
  });
final RemedyBadgeType badgeType;
  /// JSON ডেটা থেকে RemedyModel তৈরি করা
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
    );
  }
class RemedyModel {
  final String name;
  final List<String> symptoms;

  RemedyModel({required this.name, required this.symptoms});

  factory RemedyModel.fromJson(Map<String, dynamic> json) {
    return RemedyModel(
      name: json['name'] ?? '',
      symptoms: List<String>.from(json['symptoms'] ?? []),
    );
  }
}
  /// RemedyModel অবজেক্টকে JSON map-এ রূপান্তর
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
    };
  }
}