import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestNotificationPermissionSmartly() async {
  if (!Platform.isAndroid) return; // Only for Android

  final osVersion = int.tryParse(
    RegExp(r'Android (\d+)')
        .firstMatch(Platform.operatingSystemVersion)
        ?.group(1) ??
        '0',
  );

  debugPrint("📱 Android OS Version: $osVersion");

  if (osVersion != null && osVersion >= 13) {
    // 🔒 Android 13+ requires runtime notification permission
    final status = await Permission.notification.status;
    if (!status.isGranted) {
      final result = await Permission.notification.request();
      if (result.isGranted) {
        debugPrint("✅ Notification permission granted (Android 13+)");
      } else {
        debugPrint("🚫 Notification permission denied (Android 13+)");
      }
    } else {
      debugPrint("✅ Notification permission already granted (Android 13+)");
    }
  } else {
    // ✅ Android ≤12 doesn't require runtime permission
    final settings = await FirebaseMessaging.instance.requestPermission();
    debugPrint("✅ Auto-authorized on Android ≤12: ${settings.authorizationStatus}");
  }
}
