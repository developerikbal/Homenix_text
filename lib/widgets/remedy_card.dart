import 'package:flutter/material.dart';
import '../models/remedy_model.dart'; // RemedyModel definition
import '../core/constants.dart'; // Optional: use for theme, spacing, etc.

class RemedyCard extends StatelessWidget {
  final RemedyModel remedy;

  const RemedyCard({super.key, required this.remedy});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: Colors.white,
      child: ListTile(
        leading: _buildRemedyIcon(),
        title: Text(
          remedy.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          remedy.potency,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        trailing: _buildTagBadge(remedy.category),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/remedyDetail',
            arguments: remedy,
          );
        },
      ),
    );
  }

  Widget _buildRemedyIcon() {
    return const CircleAvatar(
      backgroundColor: Colors.lightGreen,
      child: Icon(Icons.healing, color: Colors.white),
    );
  }

  Widget _buildTagBadge(String category) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getCategoryColor(category),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        category,
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'mind':
        return Colors.deepPurple;
      case 'general':
        return Colors.blue;
      case 'head':
        return Colors.orange;
      case 'female':
        return Colors.pink;
      default:
        return Colors.green;
    }
  }
}