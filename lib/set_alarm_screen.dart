import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SetAlarmScreen extends StatefulWidget {
  const SetAlarmScreen({Key? key}) : super(key: key);

  @override
  _SetAlarmScreenState createState() => _SetAlarmScreenState();
}

class _SetAlarmScreenState extends State<SetAlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(padding: EdgeInsets.all(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Image(
                  image: AssetImage('assets/x.png'),
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image(
                  image: AssetImage('assets/greentick.png'),
                  height: 30,
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            child: new Swiper(
              layout: SwiperLayout.STACK,
              itemBuilder: (BuildContext context, int index) {
                return new Image.asset(
                  "assets/nature.png",
                  fit: BoxFit.scaleDown,
                );
              },
              itemCount: 3,
              itemWidth: 200,
              itemHeight: 100,
              pagination: new SwiperPagination(
                  margin: new EdgeInsets.all(0.0),
                  builder: new SwiperCustomPagination(builder:
                      (BuildContext context, SwiperPluginConfig config) {
                    return new ConstrainedBox(
                      child: new Row(
                        children: <Widget>[],
                      ),
                      constraints: new BoxConstraints.expand(height: 50.0),
                    );
                  })),
              control: new SwiperControl(
                  disableColor: Colors.transparent, color: Colors.transparent),
            ),
          ),
        ]),
      ),
    );
  }
}
