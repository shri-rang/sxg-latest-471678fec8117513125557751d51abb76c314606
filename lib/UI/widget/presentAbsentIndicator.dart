import 'package:flutter/material.dart';
import 'package:simple_x_genius/constant/colors.dart';

class PresentAbsentIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        colorBox(greenColor),
        SizedBox(
          width: 5.0,
        ),
        textData("Present"),
        SizedBox(
          width: 10.0,
        ),
        colorBox(redColor),
        SizedBox(
          width: 5.0,
        ),
        textData("Absent"),
        SizedBox(
          width: 10.0,
        ),
        colorBox(yellowColor),
        SizedBox(
          width: 5.0,
        ),
        textData("Half"),
        SizedBox(
          width: 10.0,
        ),
        colorBox(orangeColor),
        SizedBox(
          width: 5.0,
        ),
        textData("Holiday"),
      ],
    );
  }

  colorBox(Color color) {
    return Container(
      height: 6.0,
      width: 6.0,
      color: color,
    );
  }

  textData(String txt) {
    return Text(
      txt,
      style: TextStyle(fontSize: 11.0),
    );
  }
}
