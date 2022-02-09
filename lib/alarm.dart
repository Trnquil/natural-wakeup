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
}
