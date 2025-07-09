import 'package:flutter/services.dart';

class NativeNotificationHandler {
  static const MethodChannel _channel = MethodChannel('custom_notification');

  static Future<void> show({
    required String title,
    required String body,
  }) async {
    try {
      print("🟡 Calling native notification with title: $title, body: $body");
      await _channel.invokeMethod('showNotification', {
        'title': title,
        'body': body,
      });
      print("🟢 Native method called successfully");
    } catch (e) {
      print("🔴 Notification Error: $e");
    }
  }

  static Future<void> clearNotifications() async {
    try {
      await _channel.invokeMethod('clearNotifications');
    } catch (e) {
      print("🔴 Error clearing notifications: $e");
    }
  }

}
