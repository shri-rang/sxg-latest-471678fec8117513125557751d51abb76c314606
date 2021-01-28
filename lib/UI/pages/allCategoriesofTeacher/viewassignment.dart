import 'package:flutter/material.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/model/viewassignmentModel.dart';
import './teacherUploadassignment.dart';

class ViewAssignment extends StatefulWidget {
  String teacherId;
  ViewAssignment({this.teacherId});

  @override
  _ViewAssignmentState createState() => _ViewAssignmentState();
}

class _ViewAssignmentState extends State<ViewAssignment> {
  NetWorkAPiRepository _netWorkAPiRepository;
  @override
  void initState() {
    _netWorkAPiRepository = NetWorkAPiRepository();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: RaisedButton(
        //     onPressed: () {
        //       print(widget.teacherId);
        //     },
        //   ),
        // ),
        body: FutureBuilder<List<ViewAssignmentModel>>(
      future: _netWorkAPiRepository.viewAssignmentTeacher(widget.teacherId),
      builder: (context, snapshot) {
        // Container(
        //   child: Text(snapshot.data.),
        // );
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.pink, Colors.red],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red,
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          )
                        ],
                        color: Colors.red,
                        // border: Border.all(
                        //   color: Color.fromRGBO(78, 96, 98, 0.6),
                        // ),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    // color: Colors.deepOrange,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Classes: ${snapshot.data[index].classes}-${snapshot.data[index].section}',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Title: ${snapshot.data[index].title}',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Message: ${snapshot.data[index].message}',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Date and Time: ${snapshot.data[index].date}',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  color: Colors.blue,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      'View Assignment',
                                      style: TextStyle(
                                        color: Colors.white,
                                        //  fontSize: 20
                                      ),
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    // side: BorderSide(color: Colors.red)
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          TeacherUploadAssignment(
                                        assignment: snapshot.data[index],
                                        // studentInfoModel:
                                        //     widget.teacherId,
                                      ),
                                    ));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                ),

                //  ListTile(
                //   trailing: Text('View Image'),
                //   title: Text(snapshot.data[index].title),
                //   subtitle: Text(snapshot.data[index].message),
                // ),
              );
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
                child: Text('Error: ${snapshot.error}'),
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
    ));
  }
}
