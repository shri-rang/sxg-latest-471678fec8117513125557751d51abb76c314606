import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  _launchCaller() async {
    const url = "tel:+918910211212";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _lunchCaller() async {
    const url = "tel:+919934358179";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contact School'),
        ),
        body: Container(
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(30),
              child: Text(
                'HELP-DESK',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              width: 400,
              padding: EdgeInsets.all(15),
              child: Text(
                'Online Class – (through whats-app message only).',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Column(children: [
              Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Please do always mention Student Name,\n Class & Section while sending the messages..',
                    style: TextStyle(fontSize: 16),
                  )),
              RaisedButton.icon(
                  //  color: Colors.amberAccent,
                  onPressed: _launchCaller,
                  icon: Icon(Icons.phone),
                  label: Text('+918910211212'))
            ]),
            Column(children: [
              Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Contact for School Fees.',
                    style: TextStyle(fontSize: 16),
                  )),
              RaisedButton.icon(
                  onPressed: _lunchCaller,
                  icon: Icon(Icons.phone),
                  label: Text('+919934358179'))
            ]),
            Column(children: [
              Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'WhatsApp Only',
                    style: TextStyle(fontSize: 16),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/whatapp.jpg',
                      width: 50,
                      // height: 240.0,
                      // fit: BoxFit.cover,
                    ),

                    //  Image.network('https://pngimg.com/uploads/whatsapp/whatsapp_PNG20.png',
                    //  width: 50,
                  ),
                  RaisedButton(
                      // color: Colors.lightGreen,
                      onPressed: () {
                        FlutterOpenWhatsapp.sendSingleMessage("917992239925",
                            "Hi, I need help in using your App");
                      },
                      //  icon: Icon(Icons.wallpaper),
                      child: Text('+917992239925'))
                ],
              ),
            ]),
          ]),
        ));
  }
}
