// BOOK CONTROLLER - Handles all logic related to book fetching, uploading, metadata update, and deletion
// Part of: lib/controllers/book_controller.dart
// Used by: upload_book_screen.dart, book_list_screen.dart, developer_panel.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/book_model.dart';
import '../services/book_service.dart';

class BookController extends GetxController {
  // List to hold all loaded books
  RxList<BookModel> books = <BookModel>[].obs;

  // Loading state indicator
  RxBool isLoading = false.obs;

  // Load all books from Firebase
  Future<void> loadBooks() async {
    isLoading.value = true;
    try {
      final result = await BookService.getAllBooks();
      books.assignAll(result);
    } catch (e) {
      debugPrint("Error loading books: $e");
      Get.snackbar('Error', 'Failed to load books');
    } finally {
      isLoading.value = false;
    }
  }

  // Upload a new book to Firebase
  Future<void> uploadBook(BookModel newBook) async {
    isLoading.value = true;
    try {
      await BookService.uploadBook(newBook);
      books.add(newBook);
      Get.snackbar('Success', 'Book uploaded successfully');
    } catch (e) {
      debugPrint("Upload error: $e");
      Get.snackbar('Upload Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Delete a book from Firebase
  Future<void> deleteBook(String bookId) async {
    isLoading.value = true;
    try {
      await BookService.deleteBook(bookId);
      books.removeWhere((book) => book.id == bookId);
      Get.snackbar('Deleted', 'Book deleted successfully');
    } catch (e) {
      debugPrint("Delete error: $e");
      Get.snackbar('Error', 'Failed to delete book');
    } finally {
      isLoading.value = false;
    }
  }

  // Update book metadata in Firebase
  Future<void> updateBookMetadata(BookModel updatedBook) async {
    isLoading.value = true;
    try {
      await BookService.updateBookMetadata(updatedBook);
      int index = books.indexWhere((book) => book.id == updatedBook.id);
      if (index != -1) {
        books[index] = updatedBook;
      }
      Get.snackbar('Updated', 'Book metadata updated');
    } catch (e) {
      debugPrint("Metadata update error: $e");
      Get.snackbar('Error', 'Metadata update failed');
    } finally {
      isLoading.value = false;
    }
  }

  // Search books by keyword (title match)
  List<BookModel> searchBooks(String keyword) {
    return books.where(
      (book) => book.title.toLowerCase().contains(keyword.toLowerCase()),
    ).toList();
  }

  // Clear books list (used during logout or app reset)
  void clearBooks() {
    books.clear();
  }
}