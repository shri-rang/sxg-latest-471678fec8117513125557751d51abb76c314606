import 'dart:io' show Directory, Platform;
import 'dart:ui';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/chooseInboxSent.dart';
import 'package:simple_x_genius/UI/pages/studentCircular/studentCircularDetailProvider.dart';
import 'package:simple_x_genius/UI/pages/studentCircular/studentImageViewer.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/constant/colors.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_x_genius/model/circularStudenModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_x_genius/model/viewassignmentModel.dart';
import 'package:simple_x_genius/model/assignmentlist.dart';
import 'assignmentlist.dart';
import 'assignmentlist.dart';
import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/assignmentlist.dart';
// import 'uploadassignment.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

class TeacherUploadAssignment extends StatefulWidget {
  ViewAssignmentModel assignment;
  String teacherId;
  TeacherUploadAssignment({this.teacherId, this.assignment});

  @override
  _TeacherUploadAssignmentState createState() =>
      _TeacherUploadAssignmentState();
}

class _TeacherUploadAssignmentState extends State<TeacherUploadAssignment> {
  // RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);

  NetWorkAPiRepository _netWorkAPiRepository;
  // StudentUploadProvider _studentUploadProvider = StudentUploadProvider();
  String attachMentExtension;
  String _localPath;
  final TextEditingController _controllerText = TextEditingController();

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Max upload 20 MB"),
        );
      },
    );
  }

  var assignment;
  // PDFDocument document;
//  PDFDocument doc = await  PDFDocument.fromURL('$attachFileName');
  @override
  void initState() {
    _netWorkAPiRepository = NetWorkAPiRepository();
    super.initState();
  }

  Future<void> _getData() async {
    setState(() {
      _netWorkAPiRepository.listingAssignment(
          assignmentId: widget.assignment.assignmentId);
    });
  }

  // @override
  // void initState() {
  //   //  print();
  //   _netWorkAPiRepository = NetWorkAPiRepository();
  //   if (widget.readStatus == "0") {
  //     _netWorkAPiRepository.updateReadStatusDataModel(widget.messageId);
  //   }
  //   _prepare();
  //   if (widget.viewType != UIType.Circualr) {
  //     var data =
  //         Provider.of<StudentCircularDetailsProvider>(context, listen: false);
  //     data.getCircularDetailsModel(widget.messageId, widget.viewType);
  //     data.sentReplyLoading = false;
  //   }
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Upload Assignment'),
        ),
        body: Container(
            child: Column(children: [
          Container(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                elevation: 3.0,
                child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Text("From:\t" + from + "To:\t" + to),

                        // SizedBox(
                        //   height: 4.0,
                        // ),
                        // Text("Date/Time: " + date),
                        // SizedBox(
                        //   height: 4.0,
                        // ),
                        // Text("Title: " +
                        //    title),
                        // SizedBox(
                        //   height: 4.0,
                        // ),
                        // Text("Name: " + widget.assignment.name),
                        Text("Classes: " + widget.assignment.classes),
                        Text(
                          "Section:" + widget.assignment.section,
                          // style: TextStyle(
                          //     fontSize: 14,
                          //     color: Colors.white,
                          //     fontWeight: FontWeight.bold),
                        ),
                        Text("Title: " + widget.assignment.title),
                        SizedBox(
                          height: 2.0,
                        ),
                        SelectableLinkify(
                            text: "Message: " + widget.assignment.message,
                            toolbarOptions: ToolbarOptions(
                                copy: true,
                                selectAll: true,
                                cut: false,
                                paste: false),
                            onTap: () {},
                            onOpen: (link) async {
                              if (await canLaunch(link.url)) {
                                await launch(link.url);
                              } else {
                                throw 'Could not launch $link';
                              }
                            }),

                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          'Date and Time:' + widget.assignment.date,
                        ),
                        // Container(

                        // child:Text(changePDF)

                        // ),
                        Container(
                            // height: 50,
                            // width: 100,
                            child: RaisedButton(
                                color: Colors.blue,
                                child: Text(
                                  'View Image',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => StudentImageViewer(
                                      attachment: widget.assignment.docFile,
                                    ),
                                  ));
                                })),
                        // RaisedButton(
                        //   onPressed: () {
                        //     print(widget.assignment.assignmentId);
                        //     // var fileType = widget.assignment.docFile.split('.');
                        //     // print('file type ${fileType}');
                        //     // print(fileType.elementAt(2));
                        //     // var fileImgVsPdf = fileType.elementAt(2);
                        //   },
                        // ),
                        // //   PhotoView(
                        //     imageProvider: NetworkImage("$attachFileName"),
                        //   ),
                        // ),

                        // Image.network(
                        //   '$attachFileName',
                        //   height: 150,
                        //   width: 400,
                        // )),
                        // Text("Attachment: "),
                        // SizedBox(
                        //   height: 2.0,
                        // ),
                      ],
                    )),
              )),
          // Consumer<StudentUploadProvider>(
          //   builder: (context, provider, child) =>
          Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    height: 432,
                    width:
                        //  auto,
                        double.infinity,
                    child: FutureBuilder<List<AssignmentList>>(
                        future: _netWorkAPiRepository.listingAssignment(
                          assignmentId: widget.assignment.assignmentId,
                          // widget.studentInfoModel.classesID,
                          // widget.studentInfoModel.sectionID
                          // widget.studentInfoModel.studenId,
                        ),
                        builder: (context,
                            AsyncSnapshot<List<AssignmentList>> snapshot) {
                          // Container(
                          //   child: Text(snapshot.data.),

                          // }
                          if (snapshot.hasData) {
                            return RefreshIndicator(
                              onRefresh: () async {
                                await _getData();
                              },
                              child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: InkWell(
                                      // onTap: () {
                                      //   Navigator.of(context)
                                      //       .push(MaterialPageRoute(
                                      //     builder: (_) => StudentImageViewer(
                                      //         // attachment:
                                      //         //     snapshot.data[index].docFile
                                      //         ),
                                      //   ));
                                      // },
                                      child: Card(
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Name: ${snapshot.data[index].name}',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Roll No: ${snapshot.data[index].roll}',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Addmission No: ${snapshot.data[index].admNo}',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 15, 0),
                                                  child: Container(
                                                    height: 100,
                                                    width: 150,
                                                    child: Column(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                                    MaterialPageRoute(
                                                              builder: (_) => StudentImageViewer(
                                                                  attachment: snapshot
                                                                      .data[
                                                                          index]
                                                                      .docFile),
                                                            ));
                                                          },
                                                          child: Container(
                                                            child:
                                                                Image.network(
                                                              snapshot
                                                                  .data[index]
                                                                  .docFile,
                                                              fit: BoxFit.cover,
                                                              height: 100,
                                                              width: 150,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),

                                            SizedBox(
                                              height: 15,
                                            ),
                                            // Text(snapshot.data[index].),
                                          ],
                                        ),
                                      )

                                          //  Image.network(
                                          //   snapshot.data[index].docFile,
                                          //   fit: BoxFit.cover,
                                          //   height: 100,
                                          //   // width: ,
                                          // ),
                                          ),
                                    ),
                                    // ),
                                  );
                                },
                              ),
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
                        }))
              ])
        ])));
  }
}
