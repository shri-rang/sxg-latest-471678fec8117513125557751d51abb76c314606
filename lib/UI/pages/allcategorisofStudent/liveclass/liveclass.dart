import 'package:flutter/material.dart';
import './todayclasses.dart';
import './upcomingclasses.dart';
import './completedclasses.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';

class LiveClasses extends StatefulWidget {
  final StudentInfoModel studentInfoModel;

  LiveClasses({this.studentInfoModel});
  @override
  _LiveClassesState createState() => _LiveClassesState();
}

class _LiveClassesState extends State<LiveClasses> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blue),
          backgroundColor: Colors.white,
          title: Text(
            'Live Classes',
            style: TextStyle(color: Colors.blue),
          ),
          bottom: TabBar(
            // onTap: (val) {
            //    _launchURL();
            // },
            tabs: [
              Tab(
                // icon: Icon(Icons.image),
                // text: "Add Assigment",
                child: Text(
                  'Todays Classes',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Tab(
                // icon: Icon(Icons.video_call),
                child: Text(
                  'Upcoming Classes',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Tab(
                // icon: Icon(Icons.video_call),
                child: Text(
                  'Completed Classes',
                  style: TextStyle(color: Colors.blue),
                ),
              ) // text: "View Assignment")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TodayClasses(
              studentInfoModel: widget.studentInfoModel,
              // teacherId: teacherId,
            ),
            UpcomingClasses(
              studentInfoModel: widget.studentInfoModel,
              // teacherId: teacherId,
            ),
            CompletedClasses(
              studentInfoModel: widget.studentInfoModel,
              // teacherId: teacherId,
            ),
          ],
        ),
      ),
    );
  }
}
