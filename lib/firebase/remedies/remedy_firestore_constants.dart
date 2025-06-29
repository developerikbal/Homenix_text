// File: lib/firebase/remedies/remedy_firestore_constants.dart

/// This file defines Firestore collection and field constants
/// used for storing and retrieving remedy-related data.

class RemedyFirestoreConstants {
  // Firestore Collection Names
  static const String remedyCollection = 'remedies';
  static const String rubricCollection = 'rubrics';
  static const String bookCollection = 'books';

  // Remedy Fields
  static const String id = 'id';
  static const String name = 'name';
  static const String description = 'description';
  static const String grade = 'grade';
  static const String sourceBookId = 'source_book_id';
  static const String addedBy = 'added_by';
  static const String createdAt = 'created_at';

  // Rubric Fields
  static const String rubricId = 'rubric_id';
  static const String rubricName = 'rubric_name';
  static const String remedyIds = 'remedy_ids';

  // Book Fields
  static const String bookTitle = 'book_title';
  static const String bookAuthor = 'book_author';
  static const String language = 'language';
  static const String isVerified = 'is_verified';
}