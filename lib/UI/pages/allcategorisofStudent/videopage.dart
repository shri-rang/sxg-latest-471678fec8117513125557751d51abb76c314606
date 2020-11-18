import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Videopage extends StatefulWidget {
  @override
  _VideopageState createState() => _VideopageState();
}

class _VideopageState extends State<Videopage> {

    _launchURL() async {
   const url = 'https://drive.google.com/embeddedfolderview?id=1Uo6puf0OcJKpfxykdExCEKA5RXIlTMEp#grid';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}



  @override
  void initState() {
    
    super.initState();
     
     _launchURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
     
     ),

    );
  }
}