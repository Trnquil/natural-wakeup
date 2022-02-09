import 'package:flutter/cupertino.dart';

import 'alarm.dart';

class Data extends ChangeNotifier {
  List<Alarm> alarms = [Alarm()];
  int currentAlarm = 0;

  addAlarm(Alarm alarm) {
    alarms.add(alarm);
    notifyListeners();
  }

  removeAlarm(Alarm alarm) {
    alarms.remove(alarm);
    notifyListeners();
  }

  removeAllAlarms() {
    alarms = [Alarm()];
    notifyListeners();
  }
}
