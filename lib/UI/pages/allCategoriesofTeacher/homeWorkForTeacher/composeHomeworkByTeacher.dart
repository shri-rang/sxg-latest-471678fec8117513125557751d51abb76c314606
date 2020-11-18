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
  String fileExtension;
  final NetWorkAPiRepository _netWorkAPiRepository = NetWorkAPiRepository();
  @override
  void initState() {
    var data = Provider.of<GetClassSectionProvider>(context, listen: false);
    data.getClassDataModelProvider();
    super.initState();
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
                        classSectionProvder.studentInfoModels=[];
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
                                   child: Text(_file != null
                                    ? p.basename(_file.path)
                                    : "Add an attachment",maxLines: 1,),
                              )
                            ],
                          ),
                          onTap: getFilePath,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
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
                                    classSectionProvder.sectionModel != null) {
                                  voidSetLoaderState(true);
                                  var result = await _netWorkAPiRepository
                                      .setComposeMessageDataModel(
                                    isHomeWOrk: true,
                                    attachement: _file,
                                    classId:
                                        classSectionProvder.classModel.classId,
                                    sectionId: classSectionProvder
                                        .sectionModel.sectionId,
                                    fileName: _file != null
                                        ? p.basename(_file.path)
                                        : "",
                                    message: _controllerMessage.text,
                                    subject: _controllerSubject.text,
                                    teacherId: widget.teacherId,
                                    fileExtension: fileExtension??""
                                  );
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
          ? "HomeWork submitted successfully"
          : "HomeWork submission failed"),
      duration: Duration(seconds: 2),
    ));

      if(response){
      Future.delayed(Duration(seconds: 2),(){
        if (mounted){
          Navigator.of(context).pop();
        }

      } );
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
