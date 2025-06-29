import 'package:cloud_firestore/cloud_firestore.dart';

/// This model represents a registered user in the Homeonix system.
/// It maps with Firestore document under 'users' collection.
class UserModel {
  final String uid;                // Firebase UID
  final String name;              // User's full name
  final String email;             // Email used to sign up
  final String phone;             // Phone number (optional)
  final String role;              // Role: 'user', 'doctor', or 'developer'
  final bool isVerified;          // Email/Phone verified status
  final bool isPremium;           // Premium access status
  final String subscriptionType;  // 'free', 'monthly', 'yearly', 'lifetime'
  final DateTime createdAt;       // Account creation timestamp
  final DateTime? premiumExpiry;  // Validity for premium packages

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.isVerified,
    required this.isPremium,
    required this.subscriptionType,
    required this.createdAt,
    this.premiumExpiry,
  });

  /// Convert Firestore document to UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? 'user',
      isVerified: map['isVerified'] ?? false,
      isPremium: map['isPremium'] ?? false,
      subscriptionType: map['subscriptionType'] ?? 'free',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      premiumExpiry: map['premiumExpiry'] != null
          ? (map['premiumExpiry'] as Timestamp).toDate()
          : null,
    );
  }

  /// Convert UserModel instance to Firestore document map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'isVerified': isVerified,
      'isPremium': isPremium,
      'subscriptionType': subscriptionType,
      'createdAt': Timestamp.fromDate(createdAt),
      'premiumExpiry':
          premiumExpiry != null ? Timestamp.fromDate(premiumExpiry!) : null,
    };
  }
}