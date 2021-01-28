import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';
import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/attendanceSubmit/getClassSectionProvider.dart';
import 'package:simple_x_genius/UI/widget/inputDecoration.dart';
import 'package:simple_x_genius/UI/widget/raisedButtonWidget.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/constant/colors.dart';
import 'package:simple_x_genius/model/classModel.dart';
import 'package:simple_x_genius/model/sectionModel.dart';
import 'package:simple_x_genius/utility/validator.dart';
import 'package:path/path.dart' as p;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ComposeHomeWorkByTeacher extends StatefulWidget {
  final String teacherId;

  const ComposeHomeWorkByTeacher({Key key, this.teacherId}) : super(key: key);
  @override
  _ComposeHomeWorkByTeacherState createState() =>
      _ComposeHomeWorkByTeacherState();
}

class _ComposeHomeWorkByTeacherState extends State<ComposeHomeWorkByTeacher> {
  final TextEditingController _controllerSubject = TextEditingController();
  final TextEditingController _controllerMessage = TextEditingController();
  // File _image;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loaderState = false;
  File _file;
  String imageExtension;
  String fileExtension;
  bool downloading = false;
  var progressString = "";
  double _percentage = 0;
  final NetWorkAPiRepository _netWorkAPiRepository = NetWorkAPiRepository();
  @override
  void initState() {
    var data = Provider.of<GetClassSectionProvider>(context, listen: false);
    data.getClassDataModelProvider();
    super.initState();
  }

  setComposeMessageDataToServer(
      {File attachement,
      String classId,
      String sectionId,
      String subject,
      String fileName,
      String teacherId,
      String fileExtension,
      String message}) async {
    Dio _dio = Dio();
    final String url =
        "https://www.edwardses.net/edwardswebservice/Post_sendhomework.php";

    FormData formData = FormData();

    if (attachement != null) {
      formData.files.add(MapEntry(
          "uploaded_file",
          await MultipartFile.fromFile(attachement.path,
              filename: fileName,
              contentType: MediaType(
                  fileExtension == "pdf" ? 'application' : 'image',
                  fileExtension))));
    }

    formData.fields.add(
      MapEntry("classid", classId),
    );
    formData.fields.add(
      MapEntry("sectionid", sectionId),
    );
    formData.fields.add(
      MapEntry("subject", subject),
    );

    formData.fields.add(
      MapEntry("message", message),
    );
    formData.fields.add(
      MapEntry("teacherid", teacherId),
    );
    if (attachement != null) {
      formData.fields.add(
        MapEntry("attachment", fileExtension == "pdf" ? "0" : "1"),
      );
    }
    try {
      var progress;
      var response = await _dio.post(url,
          onSendProgress: (int sent, int total) {
        print('progress: $progress ($sent/$total)');
        var percentage = (sent / total) * 100;
        // _percentage = percentage / 100;
        if (percentage < 100) {
          setState(() {
            _percentage = percentage / 100;
            downloading = true;
            progressString = percentage.toStringAsFixed(0) + "%";
          });
        } else {
          setState(() {
            progressString = ' Uploading Successful';
            Navigator.pop(context);
          });
        }
      },
          data: formData,
          options: Options(headers: {"Content-Type": "multipart/form-data"}));
      print(response.data);

      // return response.data;
    } on DioError catch (e) {
      // throw e.error;
    }
    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download completed");
  }

  File _image;
  final picker = ImagePicker();

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
        _image = File(result.path);
        imageExtension = mime.split('/').last;
      });
      // setState(() {
      //   _image = File(image.path);
      //   // Image.file(new File(imagStringPathVariable)
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          "Compose HomeWork",
          style: TextStyle(color: blackColor),
        ),
        iconTheme: IconThemeData(color: blackColor),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Consumer<GetClassSectionProvider>(
        builder: (context, classSectionProvder, child) {
          return Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      child: Text(
                        "Class",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DropdownButton<ClassModel>(
                      hint: Text(classSectionProvder.classModel == null
                          ? "please select a class"
                          : classSectionProvder.classModel.className),
                      isExpanded: true,
                      items: classSectionProvder.classModels.map((value) {
                        return new DropdownMenuItem<ClassModel>(
                          value: value,
                          child: new Text(value.className),
                        );
                      }).toList(),
                      onChanged: (value) {
                        classSectionProvder.classModel = value;
                        classSectionProvder.sectionModel = null;
                        classSectionProvder.studentInfoModels = [];
                        classSectionProvder
                            .getSectionDataModelProvider(value.classId);
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      child: Text(
                        "Section",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    classSectionProvder.loaderState
                        ? Container(
                            child: Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: Text("Fetching section...")))
                        : DropdownButton<SectionModel>(
                            hint: Text(classSectionProvder.sectionModel == null
                                ? "please select a section"
                                : classSectionProvder.sectionModel.sectionName),
                            isExpanded: true,
                            items:
                                classSectionProvder.sectionModels.map((value) {
                              return new DropdownMenuItem<SectionModel>(
                                value: value,
                                child: new Text(value.sectionName),
                              );
                            }).toList(),
                            onChanged: (value) {
                              classSectionProvder.sectionModel = value;
                            },
                          ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      child: Text(
                        "Attachment",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: blackColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Row(
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
                                      : _image != null
                                          ? p.basename(_image.path)
                                          : "Add an attachment",
                                  maxLines: 1,
                                ),
                              )
                            ],
                          ),
                          onTap: getFilePath,
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          RaisedButton(
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                'Use Camera',
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
                              getImagez();
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(
                              //   builder: (context) =>
                              //       TeacherUploadAssignment(
                              //     assignment: snapshot.data[index],
                              //     // studentInfoModel:
                              //     //     widget.teacherId,
                              //   ),
                              // ));
                            },
                          ),
                          SizedBox(
                            // height: 10,
                            width: 8,
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                'Use Gallery',
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
                              getFilePath();
                              // getImagez();
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(
                              //   builder: (context) =>
                              //       TeacherUploadAssignment(
                              //     assignment: snapshot.data[index],
                              //     // studentInfoModel:
                              //     //     widget.teacherId,
                              //   ),
                              // ));
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
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
                        : Card(
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "No Data for Upload",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    // RaisedButton(
                    //   child: Text('Use Camera'),
                    //   onPressed: () {
                    //     getImagez();

                    //     // getImageFile(ImageSource.camera);
                    //   },
                    // ),
                    // RaisedButton(
                    //   child: Text('Use Camera'),
                    //   onPressed: () {
                    //     print(_image);
                    //     print(fileExtension);
                    //     // getImageFile(ImageSource.camera);
                    //   },
                    // ),
                    // Container(
                    //     height: 200,
                    //     child: _image == null
                    //         ? Text('Text')
                    //         : Text('${_image.path}')

                    //     //  Image.file(
                    //     //     _image,
                    //     //     height: 200,
                    //     //     width: 400,
                    //     //   )
                    //     ),
                    SizedBox(
                      height: 6.0,
                    ),
                    TextFormField(
                        controller: _controllerSubject,
                        validator: (v) => Validator.commonValidation(
                            v, "Subject can't be empty"),
                        style: TextStyle(
                            color: blackColor, fontWeight: FontWeight.bold),
                        decoration:
                            inputDecorationWidget("Subject", Icons.subject)),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: _controllerMessage,
                      maxLines: 3,
                      validator: (v) => Validator.commonValidation(
                          v, "Message can't be empty"),
                      decoration: inputDecorationWidget2("Message"),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    _loaderState
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : RaisedButtonWidget(
                            title: "SUBMIT",
                            callback: () async {
                              if (_formKey.currentState.validate()) {
                                if (classSectionProvder.classModel != null &&
                                    classSectionProvder.sectionModel != null) {
                                  // voidSetLoaderState(true);
                                  await setComposeMessageDataToServer(
                                      // isHomeWOrk: true,
                                      attachement: _file != null
                                          ? _file
                                          : _image != null
                                              ? _image
                                              : "",
                                      classId: classSectionProvder
                                          .classModel.classId,
                                      sectionId: classSectionProvder
                                          .sectionModel.sectionId,
                                      fileName: _file != null
                                          ? p.basename(_file.path)
                                          : _image != null
                                              ? p.basename(_image.path)
                                              : "",
                                      message: _controllerMessage.text,
                                      subject: _controllerSubject.text,
                                      teacherId: widget.teacherId,
                                      fileExtension: fileExtension != null
                                          ? fileExtension
                                          : imageExtension != null
                                              ? imageExtension
                                              : "");
                                  // var result = await _netWorkAPiRepository
                                  //     .setComposeMessageDataModel(
                                  //         isHomeWOrk: true,
                                  //         attachement: _file != null
                                  //             ? _file
                                  //             : _image != null
                                  //                 ? _image
                                  //                 : "",
                                  //         classId: classSectionProvder
                                  //             .classModel.classId,
                                  //         sectionId: classSectionProvder
                                  //             .sectionModel.sectionId,
                                  //         fileName: _file != null
                                  //             ? p.basename(_file.path)
                                  //             : _image != null
                                  //                 ? p.basename(_image.path)
                                  //                 : "",
                                  //         message: _controllerMessage.text,
                                  //         subject: _controllerSubject.text,
                                  //         teacherId: widget.teacherId,
                                  //         fileExtension: fileExtension != null
                                  //             ? fileExtension
                                  //             : imageExtension != null
                                  //                 ? imageExtension
                                  //                 : "");
                                  // voidSetLoaderState(false);

                                  // _showSnackbarMessage(result);
                                }
                              }
                            },
                          )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  voidSetLoaderState(bool newState) {
    setState(() {
      _loaderState = newState;
    });
  }

  void _showSnackbarMessage(bool response) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: response ? greenColor : redColor,
      content: Text(response
          ? "HomeWork submitted successfully"
          : "HomeWork submission failed"),
      duration: Duration(seconds: 2),
    ));

    if (response) {
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    }
  }

  // Future getImage() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     _image = image;
  //   });
  // }

  getFilePath() async {
    var temp = await FilePicker.getFile(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf']);
    if (temp != null) {
      var mime = lookupMimeType(temp.path);
      setState(() {
        _file = temp;
        fileExtension = mime.split('/').last;
      });
    }
  }
}
