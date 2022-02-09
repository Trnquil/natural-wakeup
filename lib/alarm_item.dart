import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlarmItem extends StatelessWidget {
  final String title;
  final String selectedTitle;
  final bool arrowEnabled;

  const AlarmItem({
    required this.title,
    required this.selectedTitle,
    required this.arrowEnabled,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text(title,
              style: GoogleFonts.ptSans(color: Colors.black, fontSize: 15)),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Row(
            children: [
              Text(selectedTitle,
                  style: GoogleFonts.ptSans(
                      color: Color(0xff9d9d9d), fontSize: 15)),
              Padding(padding: EdgeInsets.only(left: 10)),
              Visibility(
                visible: arrowEnabled,
                child: Image(
                  image: AssetImage('assets/right_arrow.png'),
                  height: 10,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
