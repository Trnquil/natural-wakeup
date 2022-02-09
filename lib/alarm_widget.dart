import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natural_wakeup/constants.dart';
import 'package:natural_wakeup/set_alarm_screen.dart';

import 'alarm.dart';

class AlarmWidget extends StatefulWidget {
  Alarm alarm;
  var buildContext;

  AlarmWidget({Key? key, required this.alarm, this.buildContext})
      : super(key: key);

  @override
  _AlarmWidgetState createState() => _AlarmWidgetState();
}

class _AlarmWidgetState extends State<AlarmWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SetAlarmScreen(
                      buildContext: widget.buildContext, alarm: widget.alarm)),
            );
          });
        },
        child: widget.alarm.alarmCreated
            ? Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(17, 17, 25, 17),
                      child: Image(
                          image:
                              AssetImage('assets/${widget.alarm.sound}.png')),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.alarm.time,
                            style: GoogleFonts.ptSans(
                                color: widget.alarm.alarmOn
                                    ? text_active_color
                                    : text_inactive_color,
                                fontSize: 32)),
                        Text(widget.alarm.description,
                            style: GoogleFonts.ptSans(
                                color: widget.alarm.alarmOn
                                    ? text_active_color
                                    : text_inactive_color,
                                fontSize: 15))
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image(
                              image: widget.alarm.alarmOn
                                  ? AssetImage('assets/more.png')
                                  : AssetImage('assets/more_inactive.png'),
                              height: 25,
                              width: 25),
                          Padding(
                            padding: EdgeInsets.all(6),
                          ),
                          Container(
                            child: FlutterSwitch(
                              inactiveSwitchBorder: Border.all(
                                color: controls_inactive_color,
                                width: 1.0,
                              ),
                              activeSwitchBorder: Border.all(
                                color: alarm_active_color,
                                width: 1.0,
                              ),
                              duration: Duration(milliseconds: 100),
                              activeColor: Colors.white,
                              inactiveColor: Colors.white,
                              activeToggleColor: alarm_active_color,
                              inactiveToggleColor: controls_inactive_color,
                              width: 70.0,
                              height: 28.0,
                              valueFontSize: 12.0,
                              padding: 3,
                              toggleSize: 25.0,
                              value: widget.alarm.alarmOn,
                              onToggle: (val) {
                                setState(() {
                                  widget.alarm.alarmOn = !widget.alarm.alarmOn;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                height: 100,
                decoration: BoxDecoration(
                  color: widget.alarm.alarmOn
                      ? alarm_active_color
                      : alarm_inactive_color,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
              )
            : Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(17, 17, 25, 17),
                      child: Image(
                        image: AssetImage('assets/add_alarm.png'),
                      ),
                    ),
                    Center(
                      child: Text('Add Alarm',
                          style: GoogleFonts.ptSans(
                              color: controls_inactive_color, fontSize: 17)),
                    ),
                  ],
                ),
                height: 100,
                decoration: BoxDecoration(
                  color: widget.alarm.alarmOn
                      ? alarm_active_color
                      : alarm_inactive_color,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
