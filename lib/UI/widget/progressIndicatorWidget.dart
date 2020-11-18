import 'package:flutter/material.dart';
import 'package:simple_x_genius/constant/colors.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(defaultAppBlueColor),
        
        
      );
  }
}