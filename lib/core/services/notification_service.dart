import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // init any needed services
  print('Handling a background message: ${message.messageId}');
  // you can show a notification here even when app is backgrounded
  // maybe using flutter_local_notifications
}

class NotificationService {
  static late FlutterLocalNotificationsPlugin _localNotifications;
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // iOS: request permissions
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    // initialize FlutterLocalNotificationsPlugin
    _localNotifications = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings iosInitSettings =
        const DarwinInitializationSettings();

    final InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // handle user tapping on notification
        print('Notification clicked with payload: ${response.payload}');
      },
    );

    // Set background message handler (top-level or static)
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Optionally get token
    String? token = await messaging.getToken();
    print('FCM Token: $token');
    // Save this token to your database, so server Cloud Functions or backend can use it.
  }

  static void setupForegroundListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a foreground message: ${message.notification?.title}');
      _showNotification(message);
    });
  }

  static Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'default_channel',
          'General Notifications',
          channelDescription: 'General notifications from the app',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(), // configure as needed
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
      payload: message.data['payload'] ?? '',
    );
  }
}
