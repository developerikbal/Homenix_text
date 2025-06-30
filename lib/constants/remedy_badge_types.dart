//lib/constants/remedy_badge_types.dart
import 'package:flutter/material.dart';

enum RemedyBadgeType {
  keynote,
  rare,
  deepActing,
  polychrest,
  mindActing,
  acute,
  chronic,
  nosode,
}

class RemedyBadge {
  final RemedyBadgeType type;
  final String label;
  final Color color;

  RemedyBadge({
    required this.type,
    required this.label,
    required this.color,
  });

  static RemedyBadge getBadge(RemedyBadgeType type) {
    switch (type) {
      case RemedyBadgeType.keynote:
        return RemedyBadge(
          type: type,
          label: 'Keynote',
          color: Colors.blue,
        );
      case RemedyBadgeType.rare:
        return RemedyBadge(
          type: type,
          label: 'Rare',
          color: Colors.purple,
        );
      case RemedyBadgeType.deepActing:
        return RemedyBadge(
          type: type,
          label: 'Deep Acting',
          color: Colors.teal,
        );
      case RemedyBadgeType.polychrest:
        return RemedyBadge(
          type: type,
          label: 'Polychrest',
          color: Colors.orange,
        );
      case RemedyBadgeType.mindActing:
        return RemedyBadge(
          type: type,
          label: 'Mind Acting',
          color: Colors.red,
        );
      case RemedyBadgeType.acute:
        return RemedyBadge(
          type: type,
          label: 'Acute',
          color: Colors.green,
        );
      case RemedyBadgeType.chronic:
        return RemedyBadge(
          type: type,
          label: 'Chronic',
          color: Colors.indigo,
        );
      case RemedyBadgeType.nosode:
        return RemedyBadge(
          type: type,
          label: 'Nosode',
          color: Colors.brown,
        );
    }
  }
}
