import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(const InitializationSettings(android: android));
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  /// Immediate notification
  static Future<void> showDeleteNotification(String spellName) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'delete_channel',
        'Delete Notification',
        channelDescription: 'Notifikasi saat spell favorit dihapus',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    await _plugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'Delete notification',
      'You deleted $spellName from your fav list!',
      details,
    );
  }
}
