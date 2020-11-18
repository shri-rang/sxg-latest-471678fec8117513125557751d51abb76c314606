import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:simple_x_genius/constant/colors.dart';

import 'circularNetworkImage.dart';

PreferredSize customAppBarProfile(
    {VoidCallback backTap, @required String imageUrl}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(200.0),
    child: Container(
      height: 200,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipPath(
            clipper: DiagonalPathClipperTwo(),
            child: Stack(
              children: [
                Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/student.jpg',
                      fit: BoxFit.fill,
                    )),
                Stack(
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration:
                          BoxDecoration(color: blackColor.withOpacity(0.2)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: whiteColor,
                          ),
                          onPressed: backTap),
                    )
                  ],
                )
              ],
            ),
          ),
          CircularNetworkImageWidget(
            borderadius: 100.0,
            height: 100.0,
            width: 100.0,
            imageUrl: imageUrl,
          )
          
        ],
      ),
    ),
  );
}
