// Part of: lib/controllers/book_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/book_model.dart';
import '../services/book_service.dart';

class BookController extends GetxController {
  RxList<BookModel> books = <BookModel>[].obs;
  RxBool isLoading = false.obs;

  final BookService _bookService = BookService();

  Future<void> loadBooks() async {
    isLoading.value = true;
    try {
      final result = await _bookService.fetchBooks();
      books.assignAll(result);
    } catch (e) {
      debugPrint("Error loading books: $e");
      Get.snackbar('Error', 'Failed to load books');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadBook(BookModel newBook, String filePath) async {
    isLoading.value = true;
    try {
      final fileUrl = await _bookService.uploadBookFile(newBook.localFile!, filePath);
      if (fileUrl != null) {
        newBook.downloadUrl = fileUrl;
        await _bookService.saveBookMetadata(newBook);
        books.add(newBook);
        Get.snackbar('Success', 'Book uploaded successfully');
      } else {
        Get.snackbar('Error', 'File upload failed');
      }
    } catch (e) {
      debugPrint("Upload error: $e");
      Get.snackbar('Upload Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteBook(String bookId, String filePath) async {
    isLoading.value = true;
    try {
      await _bookService.deleteBook(bookId, filePath);
      books.removeWhere((book) => book.id == bookId);
      Get.snackbar('Deleted', 'Book deleted successfully');
    } catch (e) {
      debugPrint("Delete error: $e");
      Get.snackbar('Error', 'Failed to delete book');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateBookMetadata(BookModel updatedBook) async {
    isLoading.value = true;
    try {
      await _bookService.saveBookMetadata(updatedBook);
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

  List<BookModel> searchBooks(String keyword) {
    return books
        .where((book) => book.title.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }

  void clearBooks() {
    books.clear();
  }
}
