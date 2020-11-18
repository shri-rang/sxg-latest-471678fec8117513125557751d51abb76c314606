import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './videopage.dart';
import './imagepage.dart';

class Gallarypage extends StatefulWidget {  

  @override
  _GallarypageState createState() => _GallarypageState();
}

class _GallarypageState extends State<Gallarypage> {
   _launchURL() async {
   const url = 'https://drive.google.com/embeddedfolderview?id=12kMdLdPxR6_38jeq3qH2oLL0JjkevtSO#grid';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
 @override
  void initState() {
    _launchURL();
    super.initState();
  }
  @override  
  Widget build(BuildContext context) {  
    return  
       DefaultTabController(  
        length: 2,  
        child: Scaffold(  
          appBar: AppBar(  
            title: Text('Gallery'),  
            bottom:  TabBar(  
              // onTap: (val) {
              //    _launchURL();
              // },
              tabs: [  
                Tab(icon: Icon(Icons.image), text: "Image",
                
                   ),  
                Tab(icon: Icon(Icons.video_call), text: "Video")  
              ],  
            ),  
          ),  
          body: TabBarView(  
            children: [  
                Imagepage(),
                 Videopage(),
            
            ],  
          ),  
        ),  
      );  
     
  }  
} 
