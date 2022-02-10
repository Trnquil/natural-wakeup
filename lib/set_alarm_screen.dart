import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'alarm.dart';
import 'alarm_item.dart';
import 'constants.dart';
import 'data.dart';

class SetAlarmScreen extends StatefulWidget {
  var buildContext;
  Alarm alarm;
  SetAlarmScreen({Key? key, required this.buildContext, required this.alarm})
      : super(key: key);

  @override
  _SetAlarmScreenState createState() => _SetAlarmScreenState();
}

class _SetAlarmScreenState extends State<SetAlarmScreen> {
  List<String> sounds = ["nature", "beach", "kap", "stadtbild", "berge"];
  int offset = 0;
  late Alarm newAlarm;
  TextEditingController textFieldController = TextEditingController();

  initState() {
    super.initState();
    offset = sounds.indexOf(widget.alarm.sound);
    newAlarm = widget.alarm.copy();
    textFieldController.text = newAlarm.description;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                visible: newAlarm.alarmCreated,
                child: GestureDetector(
                  onTap: () {
                    Provider.of<Data>(widget.buildContext, listen: false)
                        .removeAlarm(widget.alarm);
                    Navigator.pop(context);
                  },
                  child: Container(
                      child: Center(
                        child: Text(
                          'DELETE',
                          style: GoogleFonts.ptSans(
                              fontWeight: FontWeight.normal,
                              color: Color(0xffff0000),
                              fontSize: 15),
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                          color: Color(0x2Bff0000),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: 40,
                      width: 120),
                ),
              ),
            ),
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(padding: EdgeInsets.all(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image(
                          image: AssetImage('assets/x.png'),
                          height: 20,
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<Data>(widget.buildContext, listen: false)
                            .replaceAlarm(widget.alarm, newAlarm);

                        //because alarm is now created, make sure alarmCreated is set to true and add a new uncreated alarm
                        if (!newAlarm.alarmCreated) {
                          newAlarm.alarmCreated = true;
                          Provider.of<Data>(widget.buildContext, listen: false)
                              .addAlarm(Alarm());
                        }
                        Provider.of<Data>(widget.buildContext, listen: false)
                            .changeAlarmProperty();
                        Navigator.pop(context);
                      },
                      child: Image(
                        image: AssetImage('assets/greentick.png'),
                        height: 30,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: const EdgeInsets.only(top: 20)),
              Container(
                height: 100,
                child: new Swiper(
                  layout: SwiperLayout.DEFAULT,
                  scale: 0.2,
                  fade: 0.2,
                  viewportFraction: 0.3,
                  onIndexChanged: (int index) {
                    setState(() {
                      newAlarm.sound = sounds[(index + offset) % sounds.length];
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      "assets/${sounds[(index + offset) % sounds.length]}.png",
                      fit: BoxFit.scaleDown,
                    );
                  },
                  itemCount: sounds.length,
                  //itemWidth: 200,
                  //itemHeight: 120,
                  pagination: new SwiperPagination(
                      margin: new EdgeInsets.all(0.0),
                      builder: new SwiperCustomPagination(builder:
                          (BuildContext context, SwiperPluginConfig config) {
                        return new ConstrainedBox(
                          child: new Row(
                            children: <Widget>[],
                          ),
                          constraints: new BoxConstraints.expand(height: 0.0),
                        );
                      })),
                  control: new SwiperControl(
                      disableColor: Colors.transparent,
                      color: Colors.transparent),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              AlarmItem(
                title: "Sound",
                selectedTitle: newAlarm.sound,
                arrowEnabled: false,
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                height: 1,
                color: Color(0xff9d9d9d),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              AlarmItem(
                title: "Time",
                selectedTitle: newAlarm.time,
                arrowEnabled: true,
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                height: 1,
                color: Color(0xff9d9d9d),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text('Label',
                        style: GoogleFonts.ptSans(
                            color: Colors.black, fontSize: 15)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                          height: 25,
                          child: TextField(
                            onChanged: (value) {
                              newAlarm.description = value;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                RegExp(emojiRegexp),
                              ),
                            ],
                            cursorColor: Color(0xff9d9d9d),
                            maxLength: 20,
                            textAlign: TextAlign.right,
                            controller: textFieldController,
                            obscureText: false,
                            style: GoogleFonts.ptSans(
                                color: Color(0xff9d9d9d), fontSize: 15),
                            decoration: InputDecoration(
                                border: InputBorder.none, counterText: ''),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Visibility(
                          visible: true,
                          child: Image(
                            image: AssetImage('assets/right_arrow.png'),
                            height: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
