import 'package:flutter/material.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/model/liveclasses.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:progress_indicator_button/button_stagger_animation.dart';
import 'package:progress_indicator_button/progress_button.dart';

class TeacherTodayClasses extends StatefulWidget {
  final String id;

  TeacherTodayClasses({this.id});
  @override
  _TeacherTodayClassesState createState() => _TeacherTodayClassesState();
}

class _TeacherTodayClassesState extends State<TeacherTodayClasses> {
  NetWorkAPiRepository _netWorkAPiRepository;
  bool _loaderState = false;
  @override
  void initState() {
    // TODO: implement initState
    _netWorkAPiRepository = NetWorkAPiRepository();
    super.initState();
  }

  Future<void> _getData() async {
    setState(() {
      _netWorkAPiRepository.teacherTodayClasses(
        widget.id,
        // widget.studentInfoModel.sectionID
      );
      // listingAssignment(
      //   studentId: widget.studentInfoModel.studenId,
      //   assignmentId: widget.assignment.assignmentId,
      // );
    });
  }

  Future httpJob(AnimationController controller) async {
    controller.forward();
    print("delay start");
    await Future.delayed(Duration(seconds: 3), () {});
    print("delay stop");
    controller.reset();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      // updateListView();
    });
  }

  voidSetLoaderState(bool newState) {
    setState(() {
      _loaderState = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<TodayLiveModelTeacher>>(
        future: _netWorkAPiRepository.teacherTodayClasses(
          widget.id,
          // widget.studentInfoModel.sectionID
        ),
        builder:
            (context, AsyncSnapshot<List<TodayLiveModelTeacher>> snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
                onRefresh: () async {
                  await _getData();
                },
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var todayLive = snapshot.data[index].currentStatus;
                    _launchURL() async {
                      var url = '${snapshot.data[index].joinurl}';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }

                    return Container(
                        child: Card(
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          Text(snapshot.data[index].section),
                          SizedBox(height: 5),
                          Text(snapshot.data[index].subject),
                          SizedBox(height: 5),
                          Text(snapshot.data[index].teacher),
                          SizedBox(height: 5),
                          Text(snapshot.data[index].scheduleDate),
                          SizedBox(height: 5),
                          Text(snapshot.data[index].scheduleTime),
                          SizedBox(height: 5),
                          Text(snapshot.data[index].endTime),
                          SizedBox(height: 5),
                          // RaisedButton(
                          //   onPressed: () {
                          //     print(todayLive);
                          //   },
                          // ),
                          todayLive == 1.toString()
                              ? RaisedButton.icon(
                                  color: Colors.blue,
                                  label: Text(
                                    'start Class',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  icon: Icon(
                                    Icons.video_call,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _launchURL();
                                    // CircularProgressIndicator();
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    // side: BorderSide(color: Colors.red)
                                  ),
                                )
                              : Container(
                                  width: 120,
                                  height: 40,
                                  child: ProgressButton(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      strokeWidth: 2,
                                      child: Text(
                                        "Active Class",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                      onPressed: (AnimationController
                                          controller) async {
                                        await httpJob(controller);

                                        await _netWorkAPiRepository.classActive(
                                            widget.id,
                                            snapshot.data[index].meetingID);
                                        setState(() {});
                                      }),
                                ), // RaisedButton.icon(
                          //     color: Colors.red,
                          //     label: Text(
                          //       'Active Class',
                          //       style: TextStyle(color: Colors.white),
                          //     ),
                          //     icon: Icon(
                          //       Icons.video_call,
                          //       color: Colors.white,
                          //     ),
                          //     onPressed: (AnimationController controller ) async{
                          //       await httpJob(controller);
                          //       // voidSetLoaderState(true);
                          //       // _netWorkAPiRepository.classActive(widget.id,
                          //       //     snapshot.data[index].meetingID);
                          //       // voidSetLoaderState(false);
                          //       // _launchURL();
                          //       // print(widget.id);
                          //       setState(() {});
                          //     },
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(25.0),
                          //       // side: BorderSide(color: Colors.red)
                          //     ),
                          //   ),
                          // Text(snapshot.data[index].joinurl),
                          SizedBox(height: 15),
                        ],
                      ),
                    )
                        // ),
                        );
                  },
                ));
          } else if (snapshot.hasError) {
            return Column(
              children: [
                // RaisedButton(
                //   onPressed: () {
                //     print(widget.id);
                //   },
                // ),
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('No Record Found'),
                )
              ],
            );
            //   [

            // ];
          } else {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Center(
                    child: const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    ),
                  )
                ]);
          }
        },
      ),
    );
  }
}
