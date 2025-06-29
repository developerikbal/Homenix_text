import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String? phoneNumber;
  final String? displayName;
  final String? profileImageUrl;
  final bool isDeveloper;
  final bool isVerified;
  final String accountType; // 'free', 'trial', 'premium'
  final DateTime? subscriptionStartDate;
  final DateTime? subscriptionEndDate;

  UserModel({
    required this.uid,
    required this.email,
    this.phoneNumber,
    this.displayName,
    this.profileImageUrl,
    this.isDeveloper = false,
    this.isVerified = false,
    this.accountType = 'free',
    this.subscriptionStartDate,
    this.subscriptionEndDate,
  });

  /// Convert Firestore DocumentSnapshot to UserModel
  factory UserModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw Exception("User document data is null");
    }

    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'],
      displayName: data['displayName'],
      profileImageUrl: data['profileImageUrl'],
      isDeveloper: data['isDeveloper'] ?? false,
      isVerified: data['isVerified'] ?? false,
      accountType: data['accountType'] ?? 'free',
      subscriptionStartDate: data['subscriptionStartDate'] != null
          ? (data['subscriptionStartDate'] as Timestamp).toDate()
          : null,
      subscriptionEndDate: data['subscriptionEndDate'] != null
          ? (data['subscriptionEndDate'] as Timestamp).toDate()
          : null,
    );
  }

  /// Convert UserModel to Firestore compatible Map
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'profileImageUrl': profileImageUrl,
      'isDeveloper': isDeveloper,
      'isVerified': isVerified,
      'accountType': accountType,
      'subscriptionStartDate': subscriptionStartDate != null
          ? Timestamp.fromDate(subscriptionStartDate!)
          : null,
      'subscriptionEndDate': subscriptionEndDate != null
          ? Timestamp.fromDate(subscriptionEndDate!)
          : null,
    };
  }

  /// Subscription active checker
  bool get isSubscriptionActive {
    if (accountType == 'premium' && subscriptionEndDate != null) {
      return subscriptionEndDate!.isAfter(DateTime.now());
    }
    return false;
  }

  /// Trial user checker
  bool get isTrialUser => accountType == 'trial';

  /// Developer role checker
  bool get isDev => isDeveloper;
}