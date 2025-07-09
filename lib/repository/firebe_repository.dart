import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:map_pro/database/local_db.dart';
import 'package:map_pro/model/receiver_model.dart';
import 'package:map_pro/repository/notification_handler.dart';
import 'package:permission_handler/permission_handler.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class FirebaseRepository {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
    }
  }
  static Future<void> initFirebase() async
  {
    await Firebase.initializeApp();

    await requestNotificationPermission();

    await _messaging.requestPermission(); // Firebase-specific

    FirebaseMessaging.onMessage.listen((message) {
      final title = message.notification?.title ?? 'New Message';
      final body = message.notification?.body ?? 'You have a message';

      print("🟢 FCM Foreground Message Received: $title - $body");

      NativeNotificationHandler.show(title: title, body: body);
    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message)
    {
      print("🔁 navigatorKey.currentState = ${navigatorKey.currentState}");

      print("onMessageOpenedApp");

      navigatorKey.currentState?.pushNamed("/chats");


    });

    // 🔵 When app is launched by tapping the notification from terminated state
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      print("🟣 App launched from notification tap (terminated)");
      print("🟣 Title: ${initialMessage.notification?.title}");
      print("🟣 Body: ${initialMessage.notification?.body}");
      print("🟣 Data: ${initialMessage.data}");
    }
  }

  final fireStore = FirebaseFirestore.instance;
  final LocalDatabase db = LocalDatabase.instance;

  Future<String?> getToken() async
  {
    try {
      return await _messaging.getToken();
    } catch (e) {
      debugPrint("❌ Error getting FCM token: $e");
      return null;
    }
  }


  static const _scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

  Future<void> sendPushNotification({
    required String token,
    required String title,
    required String body,
  }) async {
    final userId = await db.getSessionValue('loggedInUserId');
    final jsonString = await rootBundle.loadString('assets/service_account.json');
    final credentials = ServiceAccountCredentials.fromJson(jsonString);
    final client = await clientViaServiceAccount(credentials, _scopes);

    final uri = Uri.parse('https://fcm.googleapis.com/v1/projects/map-pro-c914c/messages:send');

    final message = {
      "message": {
        "token": token,
        "notification": {"title": title, "body": body},
        "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK"} // ✅ required for tap
      }
    };

    final response = await client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(message),
    );

    print("FCM Response: ${response.statusCode} - ${response.body}");
  }

  Future<List<String>> getMySentMessages(String myId) async {
    final snapshot = await fireStore.collection('chats').get();
    List<String> allMessages = [];
    for (var doc in snapshot.docs) {
      final messageSnapshot = await doc.reference
          .collection('messages')
          .where('from', isEqualTo: myId)
          .orderBy('timestamp')
          .get();

      final messages = messageSnapshot.docs.map((doc) {
        final data = doc.data();
        return "${data['from']}: ${data['message']}";
      }).toList();

      allMessages.addAll(messages);
    }
    return allMessages;
  }

  Future<ReceiverModel?> receiverIdSave(
      String receiverId, String receiverName, String deviceToken) async {
    final receiver = {
      "receiverId": receiverId,
      "receiverName": receiverName,
      "deviceToken": deviceToken,
    };
    final id = await db.insertReceiverModel(receiver);
    final userData = await db.getReceiverModelById(id);
    return userData;
  }

  // Future<void> subscribeToTopic(String topic) =>
  //     _messaging.subscribeToTopic(topic);
  //
  // Future<void> unsubscribeFromTopic(String topic) =>
  //     _messaging.unsubscribeFromTopic(topic);
}
