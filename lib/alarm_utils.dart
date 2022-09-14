import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AlarmUtils {
  static void scheduleAlarm(DateTime time, title) async {
    //Initializationsettings for Android and IOS notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('x');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await FlutterLocalNotificationsPlugin().initialize(initializationSettings);

    //Details of the notification on android platform
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      importance: Importance.max,
      priority: Priority.max,
      ongoing: true,
      sound: RawResourceAndroidNotificationSound('song'),
    );

    //Details of the notification on IOS platform
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'song',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await FlutterLocalNotificationsPlugin().schedule(
        0, title, "Tap to snooze", time, platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }
}
