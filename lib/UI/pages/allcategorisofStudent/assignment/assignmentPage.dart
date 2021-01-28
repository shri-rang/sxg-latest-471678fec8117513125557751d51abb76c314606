import 'package:flutter/material.dart';
import 'package:simple_x_genius/UI/pages/allcategorisofStudent/assignment/viewstudentassignment.dart';
import './assignmentPage.dart';
import './postassignment.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';
// import 'package:simple_x_genius/model/stuentInfoModel.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/model/viewassignmentModel.dart';

class AssignmentPage extends StatefulWidget {
  final StudentInfoModel studentInfoModel;

  AssignmentPage({this.studentInfoModel});

  @override
  _AssignmentPageState createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
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
      appBar: AppBar(title: Text('Assignment')
          //  RaisedButton(
          //   onPressed: () {
          //     print(widget.teacherId);
          //   },
          // ),
          ),
      body: FutureBuilder<List<ViewAssignmentModel>>(
        future: _netWorkAPiRepository.viewStudentAssignments(
            widget.studentInfoModel.classesID, widget.studentInfoModel.sectionID
            // widget.studentInfoModel.studenId,
            ),
        builder: (context, AsyncSnapshot<List<ViewAssignmentModel>> snapshot) {
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
                    child: Card(
                      // shape:
                      // ShapeBorder(

                      // ),
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
                            // decoration: BoxDecoration(

                            //     color: Color.fromRGBO(169, 235, 224, 1),
                            //     // 169, 235, 224
                            //     border: Border.all(
                            //       color: Color.fromRGBO(78, 96, 98, 0.6),
                            //     ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        // color: Colors.deepOrange,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${snapshot.data[index].teacherId}',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
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
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Container(
                                //   height: 40,
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: RaisedButton(
                                //       color: Colors.blue,
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(3.0),
                                //         child: Text(
                                //           'Download',
                                //           style: TextStyle(
                                //             color: Colors.white,
                                //             //  fontSize: 20
                                //           ),
                                //         ),
                                //       ),
                                //       shape: RoundedRectangleBorder(
                                //         borderRadius:
                                //             BorderRadius.circular(25.0),
                                //         // side: BorderSide(color: Colors.red)
                                //       ),
                                //       onPressed: () {
                                //         // Navigator.of(context).push(MaterialPageRoute(
                                //         //   builder: (context) => AddQuestions(),
                                //         // ));
                                //       },
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  height: 40,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                      color: Colors.blue,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          'Upload Assignment',
                                          style: TextStyle(
                                            color: Colors.white,
                                            //  fontSize: 20
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        // side: BorderSide(color: Colors.red)
                                      ),
                                      onPressed: () {
                                        // setState(() {

                                        // });
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              UploadAssignment(
                                            assignment: snapshot.data[index],
                                            studentInfoModel:
                                                widget.studentInfoModel,
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
              ],
            );
            //   <Widget>[

            // ];
          }
          // return Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: children,
          //   ),
          // );
        },
      ),
    );

    // DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     backgroundColor: Colors.white,
    //     appBar: AppBar(
    //       iconTheme: IconThemeData(color: Colors.blue),
    //       backgroundColor: Colors.white,
    //       title: Text(
    //         'Assignment',
    //         style: TextStyle(color: Colors.blue),
    //       ),
    //       bottom: TabBar(
    //         // onTap: (val) {
    //         //    _launchURL();
    //         // },
    //         tabs: [
    //           Tab(
    //             // icon: Icon(Icons.image),
    //             // text: "Add Assigment",
    //             child: Text(
    //               'Upload Assigment',
    //               style: TextStyle(color: Colors.blue),
    //             ),
    //           ),
    //           Tab(
    //             // icon: Icon(Icons.video_call),
    //             child: Text(
    //               'View Assignment',
    //               style: TextStyle(color: Colors.blue),
    //             ),
    //           ) // text: "View Assignment")
    //         ],
    //       ),
    //     ),
    //     body: TabBarView(
    //       children: [
    //         PostAssignment(
    //             // teacherId: teacherId,
    //             ),
    //         ViewStudentAssignment(
    //           studentInfoModel: widget.studentInfoModel,
    //         ),
    //         // ViewStudentAssignment(
    //         //   // teacherId: teacherId,
    //         // ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
