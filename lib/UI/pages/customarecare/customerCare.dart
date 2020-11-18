import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:simple_x_genius/UI/widget/blurBackgroundImageWidget.dart';
import 'package:simple_x_genius/constant/colors.dart';

class CustomerCare extends StatefulWidget {
  final String phoneNumber;
  final bool isTeacher;

  const CustomerCare({Key key, this.phoneNumber, @required this.isTeacher})
      : super(key: key);
  @override
  _CustomerCareState createState() => _CustomerCareState();
}

class _CustomerCareState extends State<CustomerCare> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BlurBackgroundImageWidget(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                          color: blueColor,
                          onPressed: () {
                            try {
                              FlutterOpenWhatsapp.sendSingleMessage(
                                  "916255220961",
                                  "Hi, I need help in using your App");
                            } catch (e) {
                              print(e.toString());
                            }
                          },
                          child: Text(
                            "Click here to contact customer support",
                            style: TextStyle(
                              color: whiteColor,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
