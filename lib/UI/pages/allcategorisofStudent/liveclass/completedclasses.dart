import 'package:flutter/material.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/model/liveclasses.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';
import 'package:url_launcher/url_launcher.dart';

class CompletedClasses extends StatefulWidget {
  final StudentInfoModel studentInfoModel;

  CompletedClasses({this.studentInfoModel});
  @override
  _CompletedClassesState createState() => _CompletedClassesState();
}

class _CompletedClassesState extends State<CompletedClasses> {
  NetWorkAPiRepository _netWorkAPiRepository;
  @override
  void initState() {
    // TODO: implement initState
    _netWorkAPiRepository = NetWorkAPiRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<CompletedLiveModel>>(
        future: _netWorkAPiRepository.studentCompletedClasses(
            widget.studentInfoModel.classesID,
            widget.studentInfoModel.sectionID),
        builder: (context, AsyncSnapshot<List<CompletedLiveModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
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
                      // RaisedButton.icon(
                      //   color: Colors.blue,
                      //   label: Text(
                      //     'Join Class',
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      //   icon: Icon(
                      //     Icons.video_call,
                      //     color: Colors.white,
                      //   ),
                      //   onPressed: () {
                      //     _launchURL();
                      //   },
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(25.0),
                      //     // side: BorderSide(color: Colors.red)
                      //   ),
                      // ),
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
    ;
  }
}
