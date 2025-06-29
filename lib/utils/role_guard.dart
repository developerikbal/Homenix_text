// Role-based access guard for Homeonix
// Controls access to routes or widgets based on user's role

import 'package:flutter/material.dart';
import 'package:homeonix/user/user_model.dart';
import 'package:homeonix/screens/common/unauthorized_screen.dart';

/// Available user roles in Homeonix
enum UserRole {
  Developer,
  PremiumDoctor,
  FreeDoctor,
  TrialUser,
}

/// Role-based guard for widgets/routes
Widget roleGuard({
  required UserModel? user,
  required List<UserRole> allowedRoles,
  required Widget child,
}) {
  if (user == null || user.role == null || user.role!.isEmpty) {
    return const UnauthorizedScreen(reason: "User not logged in");
  }

  final roleEnum = _parseRole(user.role!);
  if (roleEnum == null) {
    return UnauthorizedScreen(reason: "Invalid role: ${user.role}");
  }

  if (allowedRoles.contains(roleEnum)) {
    return child;
  } else {
    return UnauthorizedScreen(reason: "Access denied for role: ${user.role}");
  }
}

/// Parses string role into enum
UserRole? _parseRole(String roleString) {
  switch (roleString.toLowerCase()) {
    case 'developer':
      return UserRole.Developer;
    case 'premiumdoctor':
      return UserRole.PremiumDoctor;
    case 'freedoctor':
      return UserRole.FreeDoctor;
    case 'trialuser':
      return UserRole.TrialUser;
    default:
      return null;
  }
}