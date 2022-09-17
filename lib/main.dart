import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:natural_wakeup/alarm.dart';
import 'package:natural_wakeup/alarm_widget.dart';
import 'package:natural_wakeup/constants.dart';
import 'package:provider/provider.dart';

import 'data.dart';

final int helloAlarmID = 10;
AudioPlayer player = AudioPlayer();
AudioCache cache = AudioCache();

void printHello() {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await AndroidAlarmManager.periodic(
      const Duration(seconds: 1), helloAlarmID, printHello);
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
  //index of bottom navigation bar selection
  int _selectedIndex = 0;
  double _bottomBarIconSize = 30;

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
                  await AndroidAlarmManager.oneShot(
                    const Duration(seconds: 5),
                    helloAlarmID,
                    playRingtone,
                    exact: true,
                    wakeup: true,
                  );
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

Future<void> playRingtone() async {
  await FlutterRingtonePlayer.play(
    fromAsset: "assets/song.mp3",
    looping: true, // Android only - API >= 28
    volume: 0.1, // Android only - API >= 28
    asAlarm: true, // Android only - all APIs
  );
}
