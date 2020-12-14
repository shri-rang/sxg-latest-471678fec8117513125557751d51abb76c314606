import 'package:flutter/material.dart';
import './teacherupcomingclasses.dart';
import './teachertodayclasses.dart';
import './teachercompleted.dart';
import './addclasses.dart';

class TeacherLiveClasses extends StatefulWidget {
  final String id;

  TeacherLiveClasses({this.id});
  @override
  _TeacherLiveClassesState createState() => _TeacherLiveClassesState();
}

class _TeacherLiveClassesState extends State<TeacherLiveClasses> {
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => AddClasses()));
          },
        ),
        body: TabBarView(
          children: [
            TeacherTodayClasses(
              id: widget.id,
            ),
            TeacherUpcomingClasses(
              id: widget.id,
            ),
            TeacherCompletedClasses(
              id: widget.id,
            ),
          ],
        ),
      ),
    );
  }
}
