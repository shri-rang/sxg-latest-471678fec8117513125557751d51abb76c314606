import 'package:flutter/material.dart';
import 'package:simple_x_genius/constant/colors.dart';

class InfoTileWIdget extends StatelessWidget {
  final String title;
  final String value;

  InfoTileWIdget({this.title, this.value});
  @override
  Widget build(BuildContext context) {
     return  Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all(color: blackColor,width: 1.0)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(value??"",style: TextStyle(fontWeight: FontWeight.bold )),
            ),
          ),
        ),
        Positioned(
            top: 0.0,
            left: 20.0,
            child: Container(

              child: new Text(title,style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold ),),
              color: whiteColor,
            )
        ),
      ],
    );
  }
}
