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
// import 'uploadassignment.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

class TeacherUploadAssignment extends StatefulWidget {
  ViewAssignmentModel assignment;
  String teacherId;
  TeacherUploadAssignment({this.teacherId, this.assignment});

  // final StudentInfoModel studentInfoModel;
  // TeacherUploadAssignment({this.assignment, this.studentInfoModel});
  //   final String messageId;
  // final viewType;
  // final String readStatus;
  // final bool isTeacher;
  // final String uid;
  // final CircularStudentModel circularStudentModel;

  // const StudentCircularDetails(
  //     {Key key,
  //     @required this.messageId,
  //     @required this.uid,
  //     @required this.isTeacher,
  //     this.viewType,
  //     @required this.readStatus,
  //     this.circularStudentModel})
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
      _netWorkAPiRepository.listingAssignment(widget.assignment.assignmentId);
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
        // floatingActionButton: FloatingActionButton.extended(
        //     label: Text('Upload'),
        //     icon: Icon(Icons.file_upload),
        //     backgroundColor: Colors.pink,
        //     onPressed: () async {
        //       var somefile = await FilePicker.getFile();
        //       int filesize = somefile.lengthSync();
        //       double sizeMb = filesize / (1024 * 1024);
        //       if (sizeMb > 20) {
        //         return _showDialog();
        //       } else {
        //         await _studentUploadProvider.uploadAssignmentFile(
        //             // print(widget.assignment.assignmentId),
        //             assignmentId: widget.assignment.assignmentId,
        //             studentId: widget.studentInfoModel.studenId,
        //             uploadedFile: somefile);
        //       }
        //     }),

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
                        Text("Title: " + widget.assignment.title),
                        SizedBox(
                          height: 4.0,
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
                          height: 4.0,
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
                        SizedBox(
                          height: 8.0,
                        ),

                        // widget.assignment.docFile.isNotEmpty &&
                        //         widget.assignment.docFile != "" &&
                        //         widget.assignment.docFile !=
                        //             "https://edwardses.net/uploads/attach/"
                        //     ? Container(
                        //         decoration: BoxDecoration(
                        //             border: Border.all(color: blackColor)),
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(4.0),
                        //           child: InkWell(
                        //             child: Wrap(
                        //               crossAxisAlignment:
                        //                   WrapCrossAlignment.end,
                        //               children: <Widget>[
                        //                 Icon(Icons.attachment),
                        //                 Text("Download attachment")
                        //               ],
                        //             ),
                        //             onTap: () async {
                        //               //  print(attachFileName);
                        //               //  print(fs);
                        //               // print(filesize);
                        //               // Future changePDF() async {
                        //               //   // var file = widget.circularStudentModel.attachFileName;
                        //               //   document =
                        //               //       await PDFDocument.fromURL("$attachFileName");
                        //               //   // setState(() => _isLoading = true);
                        //               // }

                        //               // changePDF();
                        //               // PDFViewer(
                        //               //   document: document,
                        //               //   zoomSteps: 1,
                        //               // );
                        //               // print(attachFileName);

                        //               if (await Permission.storage
                        //                   .request()
                        //                   .isGranted) {
                        //                 _requestDownload(
                        //                     widget.assignment.docFile);
                        //               } else {
                        //                 openAppSettings();
                        //               }

                        //               //
                        //             },
                        //           ),
                        //         ),
                        //       )
                        //     : Container(),
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
                    height: 450,
                    width: 200,
                    child: FutureBuilder<List<AssignmentList>>(
                        future: _netWorkAPiRepository
                            .listingAssignment(widget.assignment.assignmentId
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
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (_) => StudentImageViewer(
                                              attachment:
                                                  snapshot.data[index].docFile),
                                        ));
                                      },
                                      child: Card(
                                        child: Image.network(
                                          snapshot.data[index].docFile,
                                          fit: BoxFit.cover,
                                          height: 100,
                                          // width: ,
                                        ),
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
