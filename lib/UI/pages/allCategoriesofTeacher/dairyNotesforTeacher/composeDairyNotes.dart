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
import 'package:simple_x_genius/model/stuentInfoModel.dart';
import 'package:simple_x_genius/utility/validator.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ComposeDairyNotes extends StatefulWidget {
  final String teacherId;

  const ComposeDairyNotes({Key key, @required this.teacherId})
      : super(key: key);
  @override
  _ComposeDairyNotesState createState() => _ComposeDairyNotesState();
}

class _ComposeDairyNotesState extends State<ComposeDairyNotes> {
  final TextEditingController _controllerMessage = TextEditingController();
  final TextEditingController _controllerSubject = TextEditingController();
  // File _image;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loaderState = false;
  final NetWorkAPiRepository _netWorkAPiRepository = NetWorkAPiRepository();
  String studentId;
  File _file;
  String fileExtension;
  @override
  void initState() {
    var data = Provider.of<GetClassSectionProvider>(context, listen: false);
    data.getClassDataModelProvider();
    super.initState();
  }

  File _image;
  final picker = ImagePicker();

  Future getImagez() async {
    PickedFile image = await picker.getImage(source: ImageSource.camera);
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
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          "Compose DiaryNotes",
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
                        classSectionProvder.studentInfoModel = null;
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
                    classSectionProvder.dropDownLoader1
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
                              classSectionProvder.studentInfoModel = null;
                              classSectionProvder.getStudentInfoModelProvider(
                                classId: classSectionProvder.classModel.classId,
                                sectionId:
                                    classSectionProvder.sectionModel.sectionId,
                              );
                            },
                          ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      child: Text(
                        "Student",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    classSectionProvder.dropDownLoader2
                        ? Container(
                            child: Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: Text("Fetching students...")))
                        : DropdownButton<StudentInfoModel>(
                            hint: Text(classSectionProvder.studentInfoModel ==
                                    null
                                ? "please select a Student"
                                : classSectionProvder
                                        .studentInfoModel.studenName +
                                    "\t(${classSectionProvder.studentInfoModel.roll})\t"),
                            isExpanded: true,
                            items: classSectionProvder.studentInfoModels
                                .map((value) {
                              return new DropdownMenuItem<StudentInfoModel>(
                                value: value,
                                child: new Text(
                                    value.studenName + "\t(${value.roll})\t"),
                              );
                            }).toList(),
                            onChanged: (value) {
                              classSectionProvder.studentInfoModel = value;
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
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          onTap: getFilePath,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
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
                    // RaisedButton(
                    //   child: Text('Use Camera'),
                    //   onPressed: () {
                    //     getImagez();
                    //     // getImageFile(ImageSource.camera);
                    //   },
                    // ),
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
                      maxLines: 5,
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
                                    classSectionProvder.sectionModel != null &&
                                    classSectionProvder.studentInfoModel !=
                                        null) {
                                  voidSetLoaderState(true);
                                  var result = await _netWorkAPiRepository
                                      .setComposeDairyDataModel(
                                          attachement: _file,
                                          classId: classSectionProvder
                                              .classModel.classId,
                                          sectionId: classSectionProvder
                                              .sectionModel.sectionId,
                                          fileName: _file != null
                                              ? p.basename(_file.path)
                                              : "",
                                          fileExtension: fileExtension ?? "",
                                          message: _controllerMessage.text,
                                          teacherId: widget.teacherId,
                                          subject: _controllerSubject.text,
                                          studentId: classSectionProvder
                                              .studentInfoModel.studenId);
                                  voidSetLoaderState(false);

                                  _showSnackbarMessage(result);
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
          ? "DairyNote submitted successfully"
          : "DairyNote submission failed"),
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
