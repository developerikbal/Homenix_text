import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize notification service
  Future<void> initialize() async {
    // Android-specific initialization
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS-specific initialization (optional, kept for completeness)
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    // Combine platform settings
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // Initialize local notification plugin
    await _localNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onSelectNotification,
    );

    // Request FCM permission from the user
    await _firebaseMessaging.requestPermission();

    // Get device FCM token (optional: for custom backend notification)
    String? token = await _firebaseMessaging.getToken();
    debugPrint('FCM Token: $token');

    // Listen to foreground messages
    FirebaseMessaging.onMessage.listen(showForegroundNotification);

    // Handle when user taps a notification and opens the app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Notification clicked: ${message.data}');
      // You can navigate to specific screen if needed
    });
  }

  // Show notification while app is in foreground
  void showForegroundNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'homeonix_channel_id', // Must match AndroidManifest.xml channel
        'Homeonix Channel',
        channelDescription: 'For important remedy alerts and app updates',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      );

      const NotificationDetails platformDetails =
          NotificationDetails(android: androidDetails);

      await _localNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformDetails,
        payload: 'notification_payload',
      );
    }
  }

  // Called when notification is tapped
  void onSelectNotification(NotificationResponse response) {
    final String? payload = response.payload;
    debugPrint('Notification tapped with payload: $payload');

    // You may navigate to a particular screen based on payload
  }

  // Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _localNotificationsPlugin.cancelAll();
  }
}