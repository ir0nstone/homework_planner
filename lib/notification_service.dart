import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart';
import 'package:timezone/standalone.dart';

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel ID',
      'channel name',
      channelDescription: 'channel description'
  );


  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid
    );

    initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: selectNotification
    );
  }

  Future<dynamic> selectNotification(String? payload) async {}

  void pushNotification(String title, String description) async {
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        12345,
        title,
        description,
        platformChannelSpecifics,
        payload: 'data'
    );
  }

  void scheduleNotification(String title, String description, Duration duration) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      12345,
      title,
      description,
      TZDateTime.now(tz.local).add(duration),
      NotificationDetails(android: androidPlatformChannelSpecifics),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
    );
  }
}