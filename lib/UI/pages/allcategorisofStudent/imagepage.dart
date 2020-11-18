import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Imagepage extends StatefulWidget {
  @override
  _ImagepageState createState() => _ImagepageState();
}

class _ImagepageState extends State<Imagepage> {
  _launchURL() async {
   const url = 'https://drive.google.com/embeddedfolderview?id=1iqEZKib748EAWoC6Ke3JC0xB0jyttTq1#grid  ';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  _lunchURL() async {
   const url = 'https://drive.google.com/drive/u/1/folders/1iqEZKib748EAWoC6Ke3JC0xB0jyttTq1';
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
     body: Column(
       children: [
        //  Container(
        //    child: RaisedButton(
        //    child: Text('View images'),
        //    onPressed: (){
        //      _launchURL();
        //    }),
        // //  ),
        //   Container(
        //    child: RaisedButton(
        //    child: Text('Upload images'),
        //    onPressed: (){
        //      _lunchURL();
        //    }),
        //  ),
       ]
     )
     
     

    );
  }
}