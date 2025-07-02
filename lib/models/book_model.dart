import 'dart:io'; // ✅ This line added
import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  final String id;
  final String title;
  final String author;
  final String category;
  final String language;
  final String filePath;
  final String? coverUrl;
  final DateTime uploadDate;
  final bool isTranslated;
  final bool isVerified;
  final bool isDeleted;
  final int pageCount;
  final String addedBy;
  final String remarks;

  File get localFile => File(filePath); // ✅ This will now work

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
