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
import 'package:path_provider/path_provider.dart';
import 'package:simple_x_genius/model/circularStudenModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';

// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

import 'package:filesize/filesize.dart';
import 'package:preview/preview.dart';

class StudentCircularDetails extends StatefulWidget {
  final StudentInfoModel studentInfoModel;
  final String messageId;
  final viewType;
  final String readStatus;
  final bool isTeacher;
  final String uid;
  final CircularStudentModel circularStudentModel;

  const StudentCircularDetails(
      {Key key,
      this.studentInfoModel,
      @required this.messageId,
      @required this.uid,
      @required this.isTeacher,
      this.viewType,
      @required this.readStatus,
      this.circularStudentModel})
      : super(key: key);
  @override
  _StudentCircularDetailsState createState() => _StudentCircularDetailsState();
}

class _StudentCircularDetailsState extends State<StudentCircularDetails> {
  NetWorkAPiRepository _netWorkAPiRepository;
  String attachMentExtension;
  String _localPath;
  final TextEditingController _controllerText = TextEditingController();
  // PDFDocument document;
//  PDFDocument doc = await  PDFDocument.fromURL('$attachFileName');

  @override
  void initState() {
    //  print();
    _netWorkAPiRepository = NetWorkAPiRepository();
    if (widget.readStatus == "0") {
      _netWorkAPiRepository.updateReadStatusDataModel(widget.messageId);
    }
    _prepare();
    if (widget.viewType != UIType.Circualr) {
      var data =
          Provider.of<StudentCircularDetailsProvider>(context, listen: false);
      data.getCircularDetailsModel(widget.messageId, widget.viewType);
      data.sentReplyLoading = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: widget.isTeacher,
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          title: Text(
            widget.viewType == UIType.HomeWOrk
                ? "HomeWork Details"
                : widget.viewType == UIType.Circualr
                    ? "Circular Details"
                    : widget.viewType == UIType.DairyNotes
                        ? "DiaryNotes Details"
                        : "",
            style: TextStyle(color: blackColor),
          ),
          iconTheme: IconThemeData(color: blackColor),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: widget.viewType != UIType.Circualr
            ? Consumer<StudentCircularDetailsProvider>(
                builder: (context, provider, child) => Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: <Widget>[
                            provider.sendMessage != null
                                ? attachmentWidget(
                                    from: provider.sendMessage.from,
                                    to: provider.sendMessage.to,
                                    subject: provider.sendMessage.subject,
                                    message: provider.sendMessage.message,
                                    attachFileName:
                                        provider.sendMessage.attachFileName,
                                    date: provider.sendMessage.notifyTime,
                                    title: provider.sendMessage.title)
                                : Container(),
                            provider.loadingReply
                                ? Expanded(
                                    child: Center(
                                        child: CircularProgressIndicator()))
                                : Expanded(
                                    child: ListView.builder(
                                        itemCount:
                                            provider.replyMessages.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            width: double.infinity,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0)),
                                              elevation: 3.0,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 15.0,
                                                    horizontal: 15.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Text(
                                                        provider
                                                                .replyMessages[
                                                                    index]
                                                                .parentId
                                                                .isEmpty
                                                            ? "Teacher"
                                                            : provider.sendMessage !=
                                                                    null
                                                                ? provider
                                                                        .sendMessage
                                                                        .to +
                                                                    "\t(Student)"
                                                                : "" +
                                                                    "\t(Student)",
                                                        style: TextStyle(
                                                            color:
                                                                lightGreyColor,
                                                            fontSize: 9.0),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: SelectableLinkify(
                                                        text: provider
                                                            .replyMessages[
                                                                index]
                                                            .replyMessage,
                                                        onOpen: (link) async {
                                                          if (await canLaunch(
                                                              link.url)) {
                                                            await launch(
                                                                link.url);
                                                          } else {
                                                            throw 'Could not launch $link';
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    provider
                                                                .replyMessages[
                                                                    index]
                                                                .fileURL
                                                                .isNotEmpty &&
                                                            provider
                                                                    .replyMessages[
                                                                        index]
                                                                    .fileURL !=
                                                                "" &&
                                                            provider
                                                                    .replyMessages[
                                                                        index]
                                                                    .fileURL !=
                                                                "https://edwardses.net/uploads/attach/"
                                                        ? Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: Container(
                                                              width: 30,
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color:
                                                                          blackColor,
                                                                      style: BorderStyle
                                                                          .solid)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: InkWell(
                                                                  child: Wrap(
                                                                    crossAxisAlignment:
                                                                        WrapCrossAlignment
                                                                            .center,
                                                                    children: <
                                                                        Widget>[
                                                                      Icon(Icons
                                                                          .file_download),
                                                                    ],
                                                                  ),
                                                                  onTap:
                                                                      () async {
                                                                    if (await Permission
                                                                        .storage
                                                                        .request()
                                                                        .isGranted) {
                                                                      _requestDownload(provider
                                                                          .replyMessages[
                                                                              index]
                                                                          .fileURL);
                                                                    } else {
                                                                      openAppSettings();
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ))
                                                        : Container(),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Text(
                                                        provider
                                                            .replyMessages[
                                                                index]
                                                            .creationTime,
                                                        style: TextStyle(
                                                          color: lightGreyColor,
                                                          fontSize: 9.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    widget.viewType == UIType.Circualr
                        ? Container(
                            height: 2.0,
                          )
                        : Container(
                            height: 50.0,
                            child: Material(
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, right: 5.0),
                                height: 50.0,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextField(
                                        controller: _controllerText,
                                        decoration: InputDecoration(
                                          hintText: 'Reply here',
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: blueColor,
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      child: IconButton(
                                        icon: provider.sentReplyLoading
                                            ? CupertinoActivityIndicator()
                                            : Icon(
                                                Icons.send,
                                                color: Colors.white,
                                              ),
                                        onPressed: provider.loadingReply
                                            ? null
                                            : () async {
                                                if (_controllerText
                                                        .text.length >
                                                    0) {
                                                  await
                                                      //  widget.isTeacher == true
                                                      //     ? provider
                                                      //         .setMessageReply(
                                                      //             messageId: provider
                                                      //                 .sendMessage
                                                      //                 .messageID,
                                                      //             // studentId: widget
                                                      //             //     .studentInfoModel
                                                      //             //     .studenId,
                                                      //             parentId: widget
                                                      //                     .isTeacher
                                                      //                 ? ""
                                                      //                 : widget.uid,
                                                      //             replyMessage:
                                                      //                 _controllerText
                                                      //                     .text,
                                                      //             status: "0",
                                                      //             upfile: null,
                                                      //             title: provider
                                                      //                 .sendMessage
                                                      //                 .title)
                                                      //     :
                                                      provider.setMessageReply(
                                                          messageId: provider
                                                              .sendMessage
                                                              .messageID,
                                                          // studentId: widget
                                                          //     .studentInfoModel
                                                          //     .studenId,
                                                          parentId:
                                                              widget.isTeacher
                                                                  ? ""
                                                                  : widget.uid,
                                                          replyMessage:
                                                              _controllerText
                                                                  .text,
                                                          status: "0",
                                                          upfile: null,
                                                          title: provider
                                                              .sendMessage
                                                              .title);
                                                  _controllerText.clear();

                                                  provider
                                                      .getCircularDetailsModel(
                                                          provider.sendMessage
                                                              .messageID,
                                                          widget.viewType);
                                                }
                                              },
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: blueColor,
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      child: IconButton(
                                          icon: provider.sentReplyLoading
                                              ? CupertinoActivityIndicator()
                                              : Icon(
                                                  Icons.attach_file,
                                                  color: Colors.white,
                                                ),
                                          onPressed: provider.loadingReply
                                              ? null
                                              : () async {
                                                  var somefile =
                                                      await FilePicker
                                                          .getFile();
                                                  int filesize =
                                                      somefile.lengthSync();
                                                  double sizeMb =
                                                      filesize / (1024 * 1024);
                                                  if (sizeMb > 20) {
                                                    return _showDialog();
                                                  } else {
                                                    await
                                                        //  widget.isTeacher ==
                                                        //         true
                                                        //     ? provider
                                                        //         .setMessageReply(
                                                        //             messageId: provider
                                                        //                 .sendMessage
                                                        //                 .messageID,
                                                        //             // studentId: widget
                                                        //             //     .studentInfoModel
                                                        //             //     .studenId,
                                                        //             parentId:
                                                        //                 // widget.circularStudentModel.
                                                        //                 widget.isTeacher
                                                        //                     ? ""
                                                        //                     : widget
                                                        //                         .uid,
                                                        //             replyMessage: _controllerText.text ==
                                                        //                     ""
                                                        //                 ? "\t \t"
                                                        //                 : _controllerText
                                                        //                     .text,
                                                        //             status: "0",
                                                        //             title: provider
                                                        //                 .sendMessage
                                                        //                 .title,
                                                        //             upfile:
                                                        //                 somefile)
                                                        //     :
                                                        provider
                                                            .setMessageReply(
                                                                messageId: provider
                                                                    .sendMessage
                                                                    .messageID,
                                                                // studentId: widget
                                                                //     .studentInfoModel
                                                                //     .studenId,
                                                                parentId:
                                                                    // widget.circularStudentModel.
                                                                    widget.isTeacher
                                                                        ? ""
                                                                        : widget
                                                                            .uid,
                                                                replyMessage:
                                                                    _controllerText.text == ""
                                                                        ? "\t \t"
                                                                        : _controllerText
                                                                            .text,
                                                                status: "0",
                                                                title: provider
                                                                    .sendMessage
                                                                    .title,
                                                                upfile:
                                                                    somefile);
                                                    _controllerText.clear();

                                                    provider
                                                        .getCircularDetailsModel(
                                                            provider.sendMessage
                                                                .messageID,
                                                            widget.viewType);
                                                  }
                                                }),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                  ],
                ),
              )
            : attachmentWidget(
                from: "",
                to: "",
                subject: widget.circularStudentModel.subject,
                message: widget.circularStudentModel.message,
                attachFileName: widget.circularStudentModel.attachFileName,
                date: widget.circularStudentModel.notifyTime,
                title: widget.circularStudentModel.title));
  }

  Widget attachmentWidget(
      {String attachFileName,
      String from,
      String to,
      String date,
      String title,
      String subject,
      String message}) {
    print(attachFileName);
    return Container(
      width: double.infinity,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 3.0,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("From:\t" + from + "To:\t" + to),

              SizedBox(
                height: 4.0,
              ),
              Text("Date/Time: " + date),
              SizedBox(
                height: 4.0,
              ),
              // Text("Title: " +
              //    title),
              // SizedBox(
              //   height: 4.0,
              // ),
              Text("Title: " + title),
              SizedBox(
                height: 4.0,
              ),
              SelectableLinkify(
                  text: "Message: " + message,
                  toolbarOptions: ToolbarOptions(
                      copy: true, selectAll: true, cut: false, paste: false),
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
                            attachment: attachFileName,
                          ),
                        ));
                      })),
              // RaisedButton(
              //   onPressed: () {
              //     var fileType = attachFileName.split('.');
              //     print('file type ${fileType}');
              //     print(fileType.elementAt(2));
              //     var fileImgVsPdf = fileType.elementAt(2);
              //   },
              // ),
              //   PhotoView(
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

              attachFileName.isNotEmpty &&
                      attachFileName != "" &&
                      attachFileName != "https://edwardses.net/uploads/attach/"
                  ? Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: blackColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
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

                            if (await Permission.storage.request().isGranted) {
                              _requestDownload(attachFileName);
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
          ),
        ),
      ),
    );
  }

/*
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    if (status == DownloadTaskStatus.complete) {}
  }
*/
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
    _localPath =
        (await _findLocalPath()) + Platform.pathSeparator + "Attachment";

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
}
