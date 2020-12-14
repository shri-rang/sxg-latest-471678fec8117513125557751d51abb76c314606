import 'package:flutter/material.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/model/liveclasses.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

// import 'package:device_apps/device_apps.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:android_intent/android_intent.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';

class TodayClasses extends StatefulWidget {
  final StudentInfoModel studentInfoModel;

  TodayClasses({this.studentInfoModel});

  @override
  _TodayClassesState createState() => _TodayClassesState();
}

class _TodayClassesState extends State<TodayClasses> {
  // List<Map<String, String>> installedApps;

  // List<Map<String, String>> iOSApps = [
  //   {"app_name": "Calendar", "package_name": "calshow://"},
  //   {"app_name": "Facebook", "package_name": "fb://"},
  //   {"app_name": "Whatsapp", "package_name": "whatsapp://"}
  // ];

  NetWorkAPiRepository _netWorkAPiRepository;
  @override
  void initState() {
    // TODO: implement initState
    _netWorkAPiRepository = NetWorkAPiRepository();
    super.initState();
  }

  openEmailApp(BuildContext context) {
    try {
      AppAvailability.launchApp(
              Platform.isIOS ? "message://" : "us.zoom.videomeetings")
          .then((_) {
        print("App Email launched!");
      }).catchError((err) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("App Email not found!")));
        print(err);
      });
    } catch (e) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Email App not                 found!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<TodayLiveModel>>(
        future: _netWorkAPiRepository.studentTodayClasses(
            widget.studentInfoModel.classesID,
            widget.studentInfoModel.sectionID),
        builder: (context, AsyncSnapshot<List<TodayLiveModel>> snapshot) {
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

                var status = snapshot.data[index].currentStatus;
                // _openJioSavaan() async {
                //   String dt = '${snapshot.data[index].joinurl}';
                //   bool isInstalled =
                //       await DeviceApps.isAppInstalled('us.zoom.videomeetings');
                //   if (isInstalled != false) {
                //     AndroidIntent intent =
                //         AndroidIntent(action: 'action_view', data: dt);
                //     await intent.launch();
                //   } else {
                //     String url = dt;
                //     if (await canLaunch(url))
                //       await launch(url);
                //     else
                //       throw 'Could not launch $url';
                //   }
                // }

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

                      status == 1.toString()
                          ? RaisedButton.icon(
                              color: Colors.blue,
                              label: Text(
                                'Join Class',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.video_call,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // openEmailApp(context);
                                _launchURL();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                            )
                          : Container(),
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
