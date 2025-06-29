// lib/widgets/common/remedy_badge.dart

import 'package:flutter/material.dart';
import '../../constants/remedy_badge_types.dart'; // remedyBadgeTypeMap  

class RemedyBadge extends StatelessWidget {
  final String type;

  const RemedyBadge({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final color = remedyBadgeTypeMap[type] ?? Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        type,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}