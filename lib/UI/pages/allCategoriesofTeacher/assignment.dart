import 'package:flutter/material.dart';
import './addassignment.dart';
import './viewassignment.dart';

class Assignment extends StatelessWidget {
  final String teacherId;

  Assignment({this.teacherId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blue),
          backgroundColor: Colors.white,
          title: Text(
            'Assignment',
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
                  'Add Assigment',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Tab(
                // icon: Icon(Icons.video_call),
                child: Text(
                  'View Assignment',
                  style: TextStyle(color: Colors.blue),
                ),
              ) // text: "View Assignment")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AddAssignment(
              teacherId: teacherId,
            ),
            ViewAssignment(
              teacherId: teacherId,
            ),
          ],
        ),
      ),
    );
  }
}
