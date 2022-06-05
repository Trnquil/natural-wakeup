import 'dart:isolate';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:natural_wakeup/alarm.dart';
import 'package:natural_wakeup/alarm_widget.dart';
import 'package:natural_wakeup/constants.dart';
import 'package:provider/provider.dart';

import 'data.dart';

final int helloAlarmID = 0;
AudioPlayer player = AudioPlayer();
AudioCache cache = AudioCache();

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  double _bottomBarIconSize = 30;

  void scheduleAlarm() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('x');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      sound: RawResourceAndroidNotificationSound('song'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'song.mp3',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    DateTime alarmTime = DateTime.now();
    alarmTime = alarmTime.add(Duration(seconds: 5));

    await FlutterLocalNotificationsPlugin()
        .schedule(0, 'Office', "Hello", alarmTime, platformChannelSpecifics);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (_) => Data(),
      builder: (context, widget) {
        return SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  FlutterLocalNotificationsPlugin().cancelAll();
                  scheduleAlarm();
                  _getBatteryLevel();
                  _setAlarm();
                  print(_setAlarmMessage);
                  print(_batteryLevel);
                },
              ),
              body: _selectedIndex == 0
                  ? SingleChildScrollView(
                      child: Center(
                        child: Consumer<Data>(builder: (context, data, child) {
                          return Column(
                            children: getAlarmWidgets(data.alarms, context),
                          );
                        }),
                      ),
                    )
                  : Container(),
              bottomNavigationBar: Visibility(
                visible: false,
                child: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                      activeIcon: Image.asset(
                        'assets/sunrise_active.png',
                        height: _bottomBarIconSize,
                        width: _bottomBarIconSize,
                      ),
                      icon: Image.asset(
                        'assets/sunrise_inactive.png',
                        height: _bottomBarIconSize,
                        width: _bottomBarIconSize,
                      ),
                      label: 'Alarms',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Image.asset(
                        'assets/megaphone_active.png',
                        height: _bottomBarIconSize,
                        width: _bottomBarIconSize,
                      ),
                      icon: Image.asset(
                        'assets/megaphone_inactive.png',
                        height: _bottomBarIconSize,
                        width: _bottomBarIconSize,
                      ),
                      label: 'Feedback',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: alarm_active_color,
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
            ));
      },
    );
  }
}

List<Widget> getAlarmWidgets(List<Alarm> alarms, var buildContext) {
  List<Widget> widgets = [];
  widgets.add(Padding(padding: EdgeInsets.all(25)));
  for (Alarm alarm in alarms) {
    widgets.add(AlarmWidget(
      buildContext: buildContext,
      alarm: alarm,
    ));
    widgets.add(Padding(padding: EdgeInsets.all(7)));
  }
  return widgets;
}
