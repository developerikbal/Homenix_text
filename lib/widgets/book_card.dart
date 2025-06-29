import 'package:flutter/material.dart';
import 'package:homeonix/models/book_model.dart';

class BookCard extends StatelessWidget {
  final BookModel book;
  final VoidCallback onTap;

  const BookCard({
    Key? key,
    required this.book,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              _buildBookThumbnail(),
              const SizedBox(width: 16),
              Expanded(child: _buildBookDetails(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookThumbnail() {
    return Container(
      width: 60,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[300],
        image: book.coverImage != null
            ? DecorationImage(
                image: NetworkImage(book.coverImage!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: book.coverImage == null
          ? const Icon(Icons.menu_book, size: 40, color: Colors.grey)
          : null,
    );
  }

  Widget _buildBookDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          book.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          book.author ?? 'Unknown author',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}