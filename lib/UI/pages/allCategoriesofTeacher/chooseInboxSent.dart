import 'package:flutter/material.dart';
import 'package:simple_x_genius/UI/pages/inbox/inboxInfo.dart';
import 'package:simple_x_genius/UI/pages/studentCircular/studentCircularList.dart';
import 'package:simple_x_genius/UI/widget/raisedButtonWidget.dart';
import 'package:simple_x_genius/constant/colors.dart';

class ChooseOptionByTeacher extends StatelessWidget {
  final String teacherId;
  final UIType uitype;

  const ChooseOptionByTeacher({Key key, this.teacherId, @required this.uitype})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          uitype == UIType.HomeWOrk
              ? "HomeWork"
              : uitype == UIType.DairyNotes
                  ? "DiaryNotes"
                  : uitype == UIType.Circualr ? "Circular" : "",
          style: TextStyle(color: blackColor),
        ),
        iconTheme: IconThemeData(color: blackColor),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            RaisedButtonWidget(
              title: "COMPOSE",
              callback: () {
                if (uitype == UIType.HomeWOrk) {
                  Navigator.of(context).pushNamed('/composeMessageByTeacher',
                      arguments: teacherId);
                }
                if (uitype == UIType.DairyNotes) {
                  Navigator.of(context)
                      .pushNamed('/composeDairyNotes', arguments: teacherId);
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButtonWidget(
              title: "SENTBOX",
              callback: () {
                //  StudentCircularList

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => StudentCircularList(
                          id: teacherId,
                          isTeacher: true,
                          uitype:uitype,
                        )));
              },
            ),
            SizedBox(
              height: 20.0,
            ),
         Visibility(
           visible:   uitype!=UIType.Circualr ,
                    child: RaisedButtonWidget(
                title: "INBOX",
                callback: () {
                   Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => InboxInfo(
                          uid: teacherId,
                          isHomeWork: uitype==UIType.HomeWOrk ,
                        )));

                },
              ),
         )
          ],
        ),
      ),
    );
  }
}

enum UIType { HomeWOrk, Circualr, DairyNotes }
