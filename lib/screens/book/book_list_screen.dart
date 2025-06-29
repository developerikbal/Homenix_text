// lib/screens/book/book_list_screen.dart

import 'package:flutter/material.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<String> books = [
    'Boericke Materia Medica',
    'Kent Repertory',
    'Lippe Keynotes',
    'Allen Keynotes',
    'Phatak Materia Medica',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 Book List'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (_, index) => ListTile(
          leading: const Icon(Icons.book_outlined),
          title: Text(books[index]),
          onTap: () {
            // এখানে ক্লিক করলে কোন বই ওপেন হবে (future enhancement)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${books[index]} selected')),
            );
          },
        ),
      ),
    );
  }
}