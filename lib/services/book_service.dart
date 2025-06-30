import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/book_model.dart';

class BookService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<BookModel>> fetchBooks() async {
    try {
      final snapshot = await _firestore.collection('books').get();
      return snapshot.docs
          .map((doc) => BookModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print("Error fetching books: $e");
      return [];
    }
  }

  Future<String?> uploadBookFile(File bookFile, String fileName) async {
    try {
      final ref = _storage.ref().child('books/$fileName');
      await ref.putFile(bookFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print("Error uploading book file: $e");
      return null;
    }
  }

  Future<void> saveBookMetadata(BookModel book) async {
    try {
      await _firestore.collection('books').doc(book.id).set(book.toJson());
    } catch (e) {
      print("Error saving metadata: $e");
    }
  }

  Future<List<String>> listLocalBooks() async {
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      return manifestMap.keys
          .where((key) => key.contains('assets/books/raw_pdf/'))
          .toList();
    } catch (e) {
      print("Error reading local books: $e");
      return [];
    }
  }

  Future<void> deleteBook(String bookId, String filePath) async {
    try {
      await _firestore.collection('books').doc(bookId).delete();
      await _storage.refFromURL(filePath).delete();
    } catch (e) {
      print("Error deleting book: $e");
    }
  }

  Future<BookModel?> fetchBookById(String bookId) async {
    try {
      final doc = await _firestore.collection('books').doc(bookId).get();
      if (doc.exists) {
        return BookModel.fromJson(doc.data()!);
      }
    } catch (e) {
      print("Error fetching book by ID: $e");
    }
    return null;
  }
}
