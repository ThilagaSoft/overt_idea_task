package com.example.map_pro

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.graphics.BitmapFactory
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "custom_notification"
    private var notificationCount = 0  // ✅ track count manually

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            when (call.method) {
                "showNotification" -> {
                    val title = call.argument<String>("title") ?: "No Title"
                    val body = call.argument<String>("body") ?: "No Body"
                    showNotification(title, body)
                    result.success(null)
                }
                "clearNotifications" -> {
                    clearNotifications()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun showNotification(title: String, body: String) {
        val channelId = "foreground_channel"
        val notificationId = 1
        notificationCount++ // ✅ increment count for badge

        // Create notification channel (only once)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                channelId,
                "Foreground Notifications",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Used for foreground push notifications"
                // No setShowBadge() to avoid crash on old compile SDKs
            }
            val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            manager.createNotificationChannel(channel)
        }

        val largeIcon = BitmapFactory.decodeResource(resources, R.drawable.ic_launcher)

        val builder = NotificationCompat.Builder(this, channelId)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setLargeIcon(largeIcon)
            .setContentTitle(title)
            .setContentText(body)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)
            .setShowWhen(true)
            .setNumber(notificationCount) // ✅ shows badge count on supported launchers

        with(NotificationManagerCompat.from(this)) {
            notify(notificationId, builder.build())
        }
    }

    private fun clearNotifications() {
        notificationCount = 0
        val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        manager.cancelAll()
    }
}
