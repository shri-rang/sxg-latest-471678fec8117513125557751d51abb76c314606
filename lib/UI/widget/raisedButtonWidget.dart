import 'package:flutter/material.dart';
import 'package:simple_x_genius/constant/colors.dart';

class RaisedButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback callback;

  const RaisedButtonWidget({Key key, this.title, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
                height: 45.0,
                width: double.infinity,
                child: RaisedButton(
                    color: blueColor,
                    textColor: whiteColor,
                    child: Text(title),
                    onPressed:callback));
  }
}