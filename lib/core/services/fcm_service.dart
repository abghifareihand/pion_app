import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pion_app/core/config/app_config.dart';
import 'package:pion_app/core/models/fcm_model.dart';
import 'package:pion_app/core/services/pref_service.dart';

class FcmService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // ================= INIT =================
  Future<void> initialize() async {
    // request permission (iOS & Android)
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // initialize local notif
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) async {},
    );

    // ambil token FCM
    final fcmToken = await _firebaseMessaging.getToken();
    final isAuthToken = await PrefService().isLogin();
    log('FCM Token: $fcmToken');

    if (isAuthToken && fcmToken != null) {
      await _updateFcmToken(fcmToken);
    }

    // listen foreground & background
    FirebaseMessaging.onMessage.listen(_foregroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_backgroundHandler);
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
    await _firebaseMessaging.getInitialMessage();
  }

  // ================= SHOW NOTIF =================
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'com.adrprogramming.pion_app',
      'app',
      importance: Importance.max,
      priority: Priority.max,
    );
    const iosDetails = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }

  // ================= HANDLER =================
  Future<void> _foregroundHandler(RemoteMessage message) async {
    log(
      'FCM Foreground: ${message.notification?.title} - ${message.notification?.body}',
    );
    await showNotification(
      id: 0,
      title: message.notification?.title ?? 'No Title',
      body: message.notification?.body ?? 'No Body',
    );
  }

  Future<void> _backgroundHandler(RemoteMessage message) async {
    log(
      'FCM Background: ${message.notification?.title} - ${message.notification?.body}',
    );
    await showNotification(
      id: 0,
      title: message.notification?.title ?? 'No Title',
      body: message.notification?.body ?? 'No Body',
    );
  }

  Future<void> _updateFcmToken(String fcmToken) async {
    try {
      final String? authToken = await PrefService().getToken();
      if (authToken == null) return;

      final fcmRequest = FcmRequest(fcmToken: fcmToken);
      final uri = Uri.parse('${AppConfig.apiUrl}/api/auth/fcm-token');

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(fcmRequest.toJson()),
      );

      if (response.statusCode == 200) {
        final data = FcmResponse.fromJson(jsonDecode(response.body));
        log(
          '✅ FCM Token berhasil dikirim: ${data.fcmToken}, message: ${data.message}',
        );
      } else {
        log('❌ Failed to send FCM Token, status: ${response.statusCode}');
      }
    } catch (e) {
      log('❌ Error sending FCM token: $e');
    }
  }
}

// ================= BACKGROUND HANDLER =================
@pragma('vm:entry-point')
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final fcmService = FcmService();
  await fcmService._backgroundHandler(message);
}
