import 'package:flutter/material.dart';
import 'package:natural_wakeup/alarm.dart';
import 'package:natural_wakeup/alarm_widget.dart';
import 'package:natural_wakeup/constants.dart';
import 'package:provider/provider.dart';

import 'data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                backgroundColor: alarm_active_color,
                onPressed: () {
                  Provider.of<Data>(context, listen: false).removeAllAlarms();
                },
              ),
              body: _selectedIndex == 0
                  ? SingleChildScrollView(
                      child: Center(
                        child: Consumer<Data>(builder: (context, data, child) {
                          return Column(
                            children: getAlarmWidgets(data.alarms),
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

List<Widget> getAlarmWidgets(List<Alarm> alarms) {
  List<Widget> widgets = [];
  widgets.add(Padding(padding: EdgeInsets.all(25)));
  for (Alarm alarm in alarms) {
    widgets.add(AlarmWidget(
      alarm: alarm,
    ));
    widgets.add(Padding(padding: EdgeInsets.all(7)));
  }
  return widgets;
}
