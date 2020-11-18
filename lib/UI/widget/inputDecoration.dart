
import 'package:flutter/material.dart';
import 'package:simple_x_genius/constant/colors.dart';

  inputDecorationWidget(String hint,IconData icon){
    return  InputDecoration(
        labelStyle: TextStyle(
          color: blackColor,
          fontWeight: FontWeight.bold

        ),
        prefixIcon: Icon(icon,color: blackColor,),
        labelText:hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(

              color: blackColor,width:1.0),
        ),
        focusedBorder: OutlineInputBorder(

          borderSide: BorderSide(color: blackColor,width:1.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(

              color: blackColor,width:1.0),
        )
    );
  }


  inputDecorationWidget2(String hint){
    return  InputDecoration(
        hintStyle: TextStyle(
          color: blackColor
        ),

        hintText:hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(

              color: blackColor,width:1.0),
        ),
        focusedBorder: OutlineInputBorder(

          borderSide: BorderSide(color: blackColor,width:1.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(

              color: blackColor,width:1.0),
        )
    );
  }
