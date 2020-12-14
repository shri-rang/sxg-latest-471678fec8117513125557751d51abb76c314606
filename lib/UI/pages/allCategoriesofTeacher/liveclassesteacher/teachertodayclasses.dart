import 'package:flutter/material.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/model/liveclasses.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';
import 'package:url_launcher/url_launcher.dart';

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
            return ListView.builder(
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
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                            )
                          : RaisedButton.icon(
                              color: Colors.red,
                              label: Text(
                                'Active Class',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.video_call,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                voidSetLoaderState(true);
                                _netWorkAPiRepository.classActive(
                                    widget.id, snapshot.data[index].meetingID);
                                voidSetLoaderState(false);
                                // _launchURL();
                                // print(widget.id);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                            ),
                      // Text(snapshot.data[index].joinurl),
                      SizedBox(height: 15),
                    ],
                  ),
                ));
              },
            );
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
