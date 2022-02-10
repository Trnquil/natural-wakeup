class Alarm {
  String time;
  String description;
  String sound;
  bool alarmOn;
  bool alarmCreated;

  Alarm(
      {this.time = '7:00',
      this.description = 'Morning Routine',
      this.sound = 'nature',
      this.alarmOn = false,
      this.alarmCreated = false});

  fromJson(Map<String, dynamic> m) {
    time = m['time'];
    description = m['description'];
    sound = m['sound'];
    alarmOn = m['alarmOn'];
    alarmCreated = m['alarmCreated'];
  }

  String toString() {
    return "Alarm " +
        "\"" +
        sound +
        "\"" +
        " set at " +
        time +
        ". " +
        "Created: " +
        alarmCreated.toString();
  }

  Map<String, dynamic> toJson() => {
        'time': time,
        'description': description,
        'sound': sound,
        'alarmOn': alarmOn,
        'alarmCreated': alarmCreated,
      };
}
