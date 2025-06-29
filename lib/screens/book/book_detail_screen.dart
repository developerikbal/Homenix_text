import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:homeonix/models/book_model.dart';
import 'package:homeonix/services/firestore_service.dart';
import 'package:homeonix/widgets/custom_button.dart';
import 'package:homeonix/widgets/pdf_viewer.dart';

class BookDetailScreen extends StatelessWidget {
  final BookModel book;

  const BookDetailScreen({super.key, required this.book});

  bool get isDeveloper {
    final user = FirebaseAuth.instance.currentUser;
    return user != null && user.email == 'frontendwebdeveloperikbal@gmail.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: isDeveloper
            ? [
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: 'Edit Metadata',
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/developer/book-metadata',
                      arguments: book,
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete Book',
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Confirm Delete'),
                        content: const Text('Are you sure you want to delete this book?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(true),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      await FirestoreService().deleteBook(book.id);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Text(
              book.author,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8),
            Text(
              book.description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Read Book',
              icon: Icons.picture_as_pdf,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PDFViewerScreen(pdfUrl: book.pdfUrl),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            if (isDeveloper) ...[
              CustomButton(
                text: 'Open in Translator',
                icon: Icons.translate,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/developer/translate-book',
                    arguments: book,
                  );
                },
              ),
              CustomButton(
                text: 'Sync with Database',
                icon: Icons.sync,
                onPressed: () async {
                  await FirestoreService().syncBookData(book);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Book data synced!')),
                    );
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}