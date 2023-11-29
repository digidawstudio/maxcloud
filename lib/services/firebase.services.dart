import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FirebaseService {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final storage = const FlutterSecureStorage();

  static Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    await storage.write(key: 'fcmToken', value: fcmToken);

    initPushNotifications();
    print(fcmToken);
  }

  static Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  static void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    print(message.notification?.title);
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print(message.notification?.title);
  }
}
