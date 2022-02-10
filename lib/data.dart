import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'alarm.dart';

class Data extends ChangeNotifier {
  Data() {
    retrieveAlarms();
  }

  List<Alarm> alarms = [];
  final String alarmKey =
      'natural_wakeup_unique_string'; // maybe use your domain + appname

  changeAlarmProperty() {
    notifyListeners();
    writeAlarms();
  }

  replaceAlarm(Alarm oldAlarm, Alarm newAlarm) {
    int index = alarms.indexOf(oldAlarm);
    alarms.remove(oldAlarm);
    alarms.insert(index, newAlarm);
    notifyListeners();
  }

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

  writeAlarms() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(alarmKey, json.encode(alarms));
    alarms.forEach((alarm) {
      print(alarm.toString());
    });
  }

  retrieveAlarms() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getString(alarmKey) != null) {
      json.decode(sp.getString(alarmKey)!).forEach((map) {
        Alarm alarm = Alarm();
        alarm.fromJson(map);
        addAlarm(alarm);
      });
    } else {
      addAlarm(Alarm());
    }
  }
}
