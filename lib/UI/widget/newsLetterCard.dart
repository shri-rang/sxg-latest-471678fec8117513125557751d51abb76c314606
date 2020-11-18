import 'package:flutter/material.dart';
import 'package:simple_x_genius/constant/colors.dart';

class NewsLetterCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
              //  height: MediaQuery.of(context).size.height / 3,
                child: InkWell(
                  child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: <Widget>[
                              Container(
                                  width: double.infinity, child: Container()),
                              Container(
                                padding: EdgeInsets.all(3.0),
                                decoration:
                                    BoxDecoration(color: defaultAppBlueColor),
                                margin: EdgeInsets.all(10.0),
                                child: Text("11/04/2020",
                                    style: TextStyle(
                                        color: whiteColor, fontSize: 11.0)),
                              ),

                              // _categoriesList[index].imageList
                            ],
                          ),
                        ),
                        Container(
                          height: 60.0,
                          margin: EdgeInsets.only(left: 10.0, top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  child: Text("Sports Event",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                      softWrap: false,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis)),
                              Expanded(
                                child: Container(
                                    child: Text(
                                        "get ready for the new sports event which will be held at very recebt time",
                                        style: TextStyle(),
                                        softWrap: true,
                                      
                                        overflow: TextOverflow.ellipsis)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }
}