
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';



class Notifications {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();



  static Future<void> initNotifications() async {


    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await _requestNotificationPermissions();
    // await showNotification();

  }

  static Future<void> _requestNotificationPermissions() async {
    // Request notification permissions from the user
    PermissionStatus status = await Permission.notification.request();

    if (status.isDenied) {
      // The user denied the notification permission
      print('Notification permissions are denied.');
    } else if (status.isGranted) {
      // The user granted the notification permission
      print('Notification permissions are granted.');
    }
  }

  static Future<void> showNotification() async {
    print('Showing notification...');
    const String channelId = 'high_importance_channel';
    const String channelName = 'High Importance Notifications';

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.high,
    );

    const AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
      channelId,
      channelName,
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Hello, User!',
      'Genrated New Task',
      platformChannelSpecifics,
    );
  }



}