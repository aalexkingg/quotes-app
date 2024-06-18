import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: ios);
    await _notifications.initialize(settings);
  }

  static Future<void> showDailyQuoteNotification(String title, String body) async {
    final android = AndroidNotificationDetails(
      'daily_quote_channel',
      'Daily Quotes',
      'Daily notifications for quotes',
      importance: Importance.max,
      priority: Priority.high,
    );
    final ios = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: ios);

    await _notifications.zonedSchedule(
      0,
      title,
      body,
      _nextInstanceOfTenAM(),
      platform,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static tz.TZDateTime _nextInstanceOfTenAM() {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }
    return scheduledDate;
  }
}
