import 'package:cloud_firestore/cloud_firestore.dart';

/// BookModel হলো হোমিওনিক্স সফটওয়্যারের প্রতিটি বইয়ের ডেটা ধারণকারী মডেল ক্লাস।
class BookModel {
  final String id;               // ইউনিক আইডি (Firebase doc ID or local ID)
  final String title;           // বইয়ের নাম
  final String author;          // লেখক
  final String category;        // ধরন: materia medica / repertory / clinical
  final String language;        // ভাষা: English / Bengali
  final String filePath;        // লোকাল path or firebase URL
  final String? coverUrl;       // বইয়ের কভার ইমেজ (optional)
  final DateTime uploadDate;    // আপলোড বা যোগের তারিখ
  final bool isTranslated;      // বইটি বাংলা/ইংরেজিতে অনূদিত কি না
  final bool isVerified;        // ডেভেলপার দ্বারা অনুমোদিত কিনা
  final bool isDeleted;         // soft delete এর জন্য
  final int pageCount;          // মোট পৃষ্ঠা
  final String addedBy;         // কে যুক্ত করেছে (ডেভেলপার Gmail or UID)
  final String remarks;         // অতিরিক্ত মন্তব্য বা নোট
  // Add this getter
  File get localFile => File(filePath);
  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.language,
    required this.filePath,
    this.coverUrl,
    required this.uploadDate,
    required this.isTranslated,
    required this.isVerified,
    required this.isDeleted,
    required this.pageCount,
    required this.addedBy,
    required this.remarks,
  });

  /// Firestore থেকে নেওয়া map কে BookModel এ রূপান্তর
  factory BookModel.fromMap(Map<String, dynamic> map, String docId) {
    return BookModel(
      id: docId,
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      category: map['category'] ?? 'general',
      language: map['language'] ?? 'English',
      filePath: map['filePath'] ?? '',
      coverUrl: map['coverUrl'],
      uploadDate: (map['uploadDate'] as Timestamp).toDate(),
      isTranslated: map['isTranslated'] ?? false,
      isVerified: map['isVerified'] ?? false,
      isDeleted: map['isDeleted'] ?? false,
      pageCount: map['pageCount'] ?? 0,
      addedBy: map['addedBy'] ?? 'unknown',
      remarks: map['remarks'] ?? '',
    );
  }

  /// BookModel কে Map এ রূপান্তর করে Firebase বা Local DB তে পাঠাতে
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'category': category,
      'language': language,
      'filePath': filePath,
      'coverUrl': coverUrl,
      'uploadDate': Timestamp.fromDate(uploadDate),
      'isTranslated': isTranslated,
      'isVerified': isVerified,
      'isDeleted': isDeleted,
      'pageCount': pageCount,
      'addedBy': addedBy,
      'remarks': remarks,
    };
  }

  /// JSON থেকে রূপান্তর (যদি কখনো Firebase ছাড়া অন্য সোর্সে ব্যবহার হয়)
  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      category: json['category'] ?? 'general',
      language: json['language'] ?? 'English',
      filePath: json['filePath'] ?? '',
      coverUrl: json['coverUrl'],
      uploadDate: DateTime.tryParse(json['uploadDate'] ?? '') ?? DateTime.now(),
      isTranslated: json['isTranslated'] ?? false,
      isVerified: json['isVerified'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      pageCount: json['pageCount'] ?? 0,
      addedBy: json['addedBy'] ?? 'unknown',
      remarks: json['remarks'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'category': category,
        'language': language,
        'filePath': filePath,
        'coverUrl': coverUrl,
        'uploadDate': uploadDate.toIso8601String(),
        'isTranslated': isTranslated,
        'isVerified': isVerified,
        'isDeleted': isDeleted,
        'pageCount': pageCount,
        'addedBy': addedBy,
        'remarks': remarks,
      };
}
