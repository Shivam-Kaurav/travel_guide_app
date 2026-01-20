import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:travel_guide_app/core/notifications/notification_service.dart';

class FirebaseNotificationService implements NotificationService {
  final FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _localNotification;
  FirebaseNotificationService(this._firebaseMessaging, this._localNotification);
  @override
  Future<void> init() async {
    await _firebaseMessaging.requestPermission();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initializationSetting = InitializationSettings(
      android: androidSettings,
    );

    await _localNotification.initialize(initializationSetting);
  }

  @override
  Future<void> show({required String title, required String body}) async {
    final androidDetails = AndroidNotificationDetails(
      'auth_channel',
      'Auth Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    final notificationDetails = NotificationDetails(android: androidDetails);

    await _localNotification.show(0, title, body, notificationDetails);
  }
}
