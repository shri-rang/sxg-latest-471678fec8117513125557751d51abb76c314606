import 'package:flutter/material.dart';
import 'package:simple_x_genius/constant/colors.dart';

class StudentCardWidget extends StatelessWidget {
  final String studenName;

  const StudentCardWidget({Key key, this.studenName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 8.0,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                  image: AssetImage("assets/images/student.png"),
                  fit: BoxFit.cover),
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: defaultAppBlueColor.withOpacity(0.2)),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
               studenName?? "Student Name",
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
