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
            child: new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new Image.network(
                  "http://via.placeholder.com/350x150",
                  fit: BoxFit.fill,
                );
              },
              itemCount: 3,
              pagination: new SwiperPagination(),
              control: new SwiperControl(),
            ),
          ),
          Container(
            height: 200,
            child: RotatedBox(
              quarterTurns: 1,
              child: ListWheelScrollView(
                  itemExtent: 100,
                  diameterRatio: 1.5,
                  offAxisFraction: 0.4,
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Image(
                        image: AssetImage('assets/nature.png'),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Image(
                        image: AssetImage('assets/nature.png'),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Image(
                        image: AssetImage('assets/nature.png'),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Image(
                        image: AssetImage('assets/beach.png'),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Image(
                        image: AssetImage('assets/nature.png'),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Image(
                        image: AssetImage('assets/nature.png'),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Image(
                        image: AssetImage('assets/nature.png'),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Image(
                        image: AssetImage('assets/nature.png'),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Image(
                        image: AssetImage('assets/nature.png'),
                      ),
                    ),
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}
