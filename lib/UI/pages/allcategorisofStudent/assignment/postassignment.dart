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
import 'uploadassignment.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:mime/mime.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:dio/dio.dart';

class UploadAssignment extends StatefulWidget {
  ViewAssignmentModel assignment;
  final StudentInfoModel studentInfoModel;
  UploadAssignment({this.assignment, this.studentInfoModel});

  @override
  _UploadAssignmentState createState() => _UploadAssignmentState();
}

class _UploadAssignmentState extends State<UploadAssignment> {
  // RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  NetWorkAPiRepository _netWorkAPiRepository;
  StudentUploadProvider _studentUploadProvider = StudentUploadProvider();
  String attachMentExtension;
  String _localPath;
  final TextEditingController _controllerText = TextEditingController();

  final picker = ImagePicker();
  File _file;
  String imageExtension;
  // String fileExtension;
  String _image;
  var uploading = "intializing";
  bool _isUploading = false;
  // final imgUrl = "https://unsplash.com/photos/iEJVyyevw-U/download?force=true";
  bool downloading = false;
  var progressString = "";
  double _percentage = 0;
  // Future<void> downloadFile() async {
  //   Dio dio = Dio();

  //   try {
  //     var dir = await getApplicationDocumentsDirectory();

  //     await dio.download(imgUrl, "${dir.path}/myimage.jpg",
  //         onReceiveProgress: (rec, total) {
  //       print("Rec: $rec , Total: $total");

  //       setState(() {
  //         downloading = true;
  //         progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
  //       });
  //     });
  //   } catch (e) {}
  //   setState(() {
  //     downloading = false;
  //     progressString = "Completed";
  //   });
  //   print("Download completed");
  // }
  Future uploadAssingment({
    String assignmentId,
    String studentId,
    File uploadedFile,
    String fileName,
    String uploadMessage,
    // String fileExtension
  }) async {
    Dio dio = Dio();
    print(uploadedFile);
    print(fileName);
    // print(fileExtension);
    final String url =
        "https://www.edwardses.net/edwardswebservice/Post_assignmentreply.php";

    FormData formData = FormData();
    // var request = http.MultipartRequest('POST', Uri.parse(url));
    // request.fields["assignmentID"] = assignmentId;
    // request.fields["studentID"] = studentId;

    formData.files.add(MapEntry(
        "uploaded_file",
        await MultipartFile.fromFile(
          uploadedFile.path,
          filename: fileName,
          // contentType: MediaType(
          //     // fileExtension == "pdf" ? 'application' : 'image',
          //     // fileExtension
          //     )
        )));

    formData.fields.add(
      MapEntry("assignmentID", assignmentId),
    );
    formData.fields.add(
      MapEntry("studentID", studentId),
    );
    var progress;
    try {
      var response = await dio.post(url,
          //     onSendProgress: (actualbytes, totalbytes) {
          //   uploadMessage = actualbytes.toString();
          // },

          onSendProgress: (int sent, int total) {
        // progress = sent / total;
        print('progress: $progress ($sent/$total)');
        var percentage = (sent / total) * 100;
        // _percentage = percentage / 100;
        if (percentage < 100) {
          setState(() {
            _percentage = percentage / 100;
            downloading = true;
            progressString = percentage.toStringAsFixed(0) + "%";
          });
        } else {}
        setState(() {
          progressString = ' Uploading Successful';
        });
      },
          data: formData,
          options: Options(
              method: 'POST',
              headers: {"Content-Type": "multipart/form-data"}));
      //  await request.send();
      print(response.data);

      // return response.data;
      // return response.data;
    } on DioError catch (e) {}
    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download completed");
  }

  Future getImagez() async {
    PickedFile image = await picker.getImage(source: ImageSource.camera);

    if (image != null) {
      var mime = lookupMimeType(image.path);
      File file = File(image.path);
      print('nonCom:${file.lengthSync()}');
      final filePath = file.absolute.path;
      //   // Create output file path
      //   // eg:- "Volume/VM/abcd_out.jpeg"
      final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
      final splitted = filePath.substring(0, (lastIndex));
      final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
      var result = await FlutterImageCompress.compressAndGetFile(
        image.path,
        outPath,
        // outPath,
        quality: 15,
      );
      setState(() {
        _file = File(result.path);
        _image = image.path.split('/').last;
        // print('nonCom:${file.lengthSync()}');
        print('comp: ${_file.lengthSync()}');
        // imageExtension = mime.split('/').last;
      });
    }
  }

  // Future<File> compressFile(File _file) async {
  //   final filePath = _file.absolute.path;

  //   // Create output file path
  //   // eg:- "Volume/VM/abcd_out.jpeg"
  //   final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
  //   final splitted = filePath.substring(0, (lastIndex));
  //   final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
  //   var result = await FlutterImageCompress.compressAndGetFile(
  //     _file.absolute.path,
  //     outPath,
  //     quality: 5,
  //   );

  //   print('lenth:${_file.lengthSync()}');
  //   print(result.lengthSync());

  //   return result;
  // }

  // void _showDialog() {
  //   // flutter defined function
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return AlertDialog(
  //         title: new Text("Max upload 20 MB"),
  //       );
  //     },
  //   );
  // }

  // void _showSnackbarMessage(bool response) {
  //   _scaffoldKey.currentState.showSnackBar(SnackBar(
  //     backgroundColor: response ? greenColor : redColor,
  //     content: Text(response
  //         ? "Assignment Uploaded Succecfully"
  //         : "Assignment Upload failed"),
  //     duration: Duration(seconds: 2),
  //   ));
  // }

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
        studentId: widget.studentInfoModel.studenId,
        assignmentId: widget.assignment.assignmentId,
      );
    });
  }

  upload(var result) {
    if (result != null) {
      setState(() {
        uploading = "uploded ";
      });
    }
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
    _showBottomsheet() {
      showBottomSheet(
          context: context,
          builder: (context) => Container(
                color: Colors.pink,
                height: 250,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      child: Text(
                        "Assignment",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue)),
                        label: Text(
                          'Take Image From Camera',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          getImagez();
                        },
                        color: Colors.blue),
                    SizedBox(
                      width: 10.0,
                    ),
                    RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue)),
                        label: Text(
                          'Click to Upload Image',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: Icon(
                          Icons.file_upload,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          uploadAssingment(
                            assignmentId: widget.assignment.assignmentId,
                            studentId: widget.studentInfoModel.studenId,
                            uploadedFile: _file,
                            fileName: _image,
                          );
                        },
                        color: Colors.blue),
                    // ],
                    // ),
                    SizedBox(
                      height: 40.0,
                    ),
                    FlatButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)),
                      label: Text(
                        'close',
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ));
    }

    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Upload Assignment'),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // FloatingActionButton.extended(
          //     heroTag: null,
          //     label: Text(
          //       'Upload',
          //       style: TextStyle(fontSize: 12),
          //     ),
          //     icon: Icon(Icons.file_upload),
          //     backgroundColor: Colors.pink,
          //     onPressed: () async {
          //       // downloadFile();
          //       uploadAssingment(
          //         assignmentId: widget.assignment.assignmentId,
          //         studentId: widget.studentInfoModel.studenId,
          //         uploadedFile: _file,
          //         fileName: _image,
          //       );
          //       // var result;
          //       // result = await _studentUploadProvider.uploadAssignmentFile(
          //       //   // print(widget.assignment.assignmentId),
          //       //   assignmentId: widget.assignment.assignmentId,
          //       //   studentId: widget.studentInfoModel.studenId,
          //       //   uploadedFile: _file,
          //       //   fileName: _image,

          //       //   uploadMessage: uploading,
          //       //   // fileExtention: imageExtension,
          //       // );
          //       // print('this is result: $result');
          //       // upload(result);
          //       // var somefile = await FilePicker.getFile();
          //       // int filesize = somefile.lengthSync();
          //       // double sizeMb = filesize / (1024 * 1024);
          //       // if (sizeMb > 20) {
          //       //   return _showDialog();
          //       // } else {
          //       //   await _studentUploadProvider.uploadAssignmentFile(
          //       //       // print(widget.assignment.assignmentId),
          //       //       assignmentId: widget.assignment.assignmentId,
          //       //       studentId: widget.studentInfoModel.studenId,
          //       //       uploadedFile: somefile);
          //     }),
          // SizedBox(
          //   height: 4,
          // ),

          FloatingActionButton.extended(
              heroTag: null,
              label: Text(
                'Upload',
                style: TextStyle(fontSize: 12),
              ),
              icon: Icon(Icons.upload_sharp),
              backgroundColor: Colors.pink,
              onPressed: () async {
                // getImagez();
                _showBottomsheet();
                //   _scaffoldKey.currentState.showBottomSheet(
                //       // context: context,
                //       // builder:
                //       (context) =>

                //   // _showSnackbarMessage(result);
              }),
        ],
      ),

      body: Container(
        // height: 800,
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
                        // Text(uploading ?? ''),
                        // Text(_image.path),
                        // Text(imageExtension),
                        // RaisedButton(
                        //   onPressed: () async {
                        //     await _studentUploadProvider.uploadAssignmentFile(
                        //       // print(widget.assignment.assignmentId),
                        //       assignmentId: widget.assignment.assignmentId,
                        //       studentId: widget.studentInfoModel.studenId,
                        //       uploadedFile: _file,
                        //       fileName: _image,
                        //       // fileExtention: imageExtension,
                        //     );
                        //   },
                        // ),

                        // Image.file(_image),
                        // Text(),
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

                        widget.assignment.docFile.isNotEmpty &&
                                widget.assignment.docFile != "" &&
                                widget.assignment.docFile !=
                                    "https://edwardses.net/uploads/attach/"
                            ? Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: blackColor)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: InkWell(
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.end,
                                      children: <Widget>[
                                        Icon(Icons.attachment),
                                        Text("Download attachment")
                                      ],
                                    ),
                                    onTap: () async {
                                      //  print(attachFileName);
                                      //  print(fs);
                                      // print(filesize);
                                      // Future changePDF() async {
                                      //   // var file = widget.circularStudentModel.attachFileName;
                                      //   document =
                                      //       await PDFDocument.fromURL("$attachFileName");
                                      //   // setState(() => _isLoading = true);
                                      // }

                                      // changePDF();
                                      // PDFViewer(
                                      //   document: document,
                                      //   zoomSteps: 1,
                                      // );
                                      // print(attachFileName);

                                      if (await Permission.storage
                                          .request()
                                          .isGranted) {
                                        _requestDownload(
                                            widget.assignment.docFile);
                                      } else {
                                        openAppSettings();
                                      }

                                      //
                                    },
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    )),
              )),
          // Consumer<StudentUploadProvider>(
          //   builder: (context, provider, child) =>
          Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Card(
                child: Container(
                  height: 105,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: blackColor),
                            borderRadius: BorderRadius.circular(10),
                            // shape:
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: InkWell(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.file_upload,
                                    color: blackColor,
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      _file != null
                                          ? p.basename(_file.path)
                                          // : _image != null
                                          // ? p.basename(_image.path)
                                          : "Upload an assignment",
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              // onTap: getFilePath,
                            ),
                          ),
                        ),
                      ),
                      downloading
                          ? Container(
                              // height: 100.0,
                              // width: 200.0,
                              child: Card(
                                // color: Colors.black,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // CircularProgressIndicator(),
                                    // SizedBox(
                                    //   height: 20.0,
                                    // ),
                                    Text(
                                      "Uploading File: $progressString",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    LinearProgressIndicator(
                                      // minHeight: 20,
                                      value: _percentage,
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Text(
                              "No Data",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              Container(
                  height: 415,
                  width: 200,
                  child: FutureBuilder<List<AssignmentList>>(
                      future: _netWorkAPiRepository.listingAssignment(
                        studentId: widget.studentInfoModel.studenId,
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
                              // physics:
                              // scrollDirection: Axis.horizontal,
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
                                child: Text('No Result Found'),
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
                      })),
              // Container(
              //     // height: 200,
              //     alignment: Alignment.bottomCenter,
              //     // AlignmentGeometry(

              //     // ),
              //     // height: ,
              //     child: RaisedButton.icon(
              //         icon: Icon(
              //           Icons.file_upload,
              //           color: Colors.white,
              //         ),
              //         color: Colors.blue,
              //         label: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             'Upload',
              //             style: TextStyle(
              //               color: Colors.white,
              //               //  fontSize: 20
              //             ),
              //           ),
              //         ),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(25.0),
              //           // side: BorderSide(color: Colors.red)
              //         ),
              //         onPressed: () async {
              //           // setState(() {
              //           //   _netWorkAPiRepository.listingAssignment(
              //           //       widget.assignment.assignmentId);
              //           // });

              //           // print(widget.assignment.assignmentId);
              //           var somefile = await FilePicker.getFile();
              //           int filesize = somefile.lengthSync();
              //           double sizeMb = filesize / (1024 * 1024);
              //           if (sizeMb > 20) {
              //             return _showDialog();
              //           } else {
              //             await _studentUploadProvider.uploadAssignmentFile(
              //                 // print(widget.assignment.assignmentId),
              //                 assignmentId: widget.assignment.assignmentId,
              //                 studentId: widget.studentInfoModel.studenId,
              //                 uploadedFile: somefile);
              //           }
              //         })),
            ],
          ),
          // )
        ]),
      ),
      // ),
    );
  }
}

String _localPath;

void _requestDownload(String url) async {
  print(url);
  String localPath =
      (await _findLocalPath()) + Platform.pathSeparator + "Attachment";

  final savedDir = Directory(_localPath);
  bool hasExisted = await savedDir.exists();
  if (!hasExisted) {
    savedDir.create();
  }
  await FlutterDownloader.enqueue(
    url: url,
    savedDir: localPath,
    showNotification: true,
    openFileFromNotification: true,
  );
}

Future<Null> _prepare() async {
  _localPath = (await _findLocalPath()) + Platform.pathSeparator + "Attachment";

  final savedDir = Directory(_localPath);
  bool hasExisted = await savedDir.exists();
  if (!hasExisted) {
    savedDir.create();
  }
}

Future<String> _findLocalPath() async {
  final directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();
  return directory.path;
}
