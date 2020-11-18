import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_x_genius/api/userTokenProvider.dart';
import 'package:simple_x_genius/constant/registerNotification.dart';


import 'home/homeMain.dart';
import 'login/loginPage.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() { 
    super.initState();
    configLocalNotification();
    registerNotification();
  }
  @override
  Widget build(BuildContext context) {
    
      var tokenRepo = Provider.of<UserTokenProvider>(context);
    return tokenRepo.getUserToken().isEmpty? LoginPage():HomeMainPage();
  }
}