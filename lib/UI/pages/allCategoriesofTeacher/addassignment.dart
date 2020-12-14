import 'package:flutter/material.dart';
import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/addquestion.dart';
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

class AddAssignment extends StatefulWidget {
  final String teacherId;

  AddAssignment({this.teacherId});
  @override
  _AddAssignmentState createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {
  final _formKey = GlobalKey<FormState>();
  // TextEditingController _imageController = TextEditingController();
  // TextEditingController _titleController = TextEditingController();
  // TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _controllerSubject = TextEditingController();
  final TextEditingController _controllerMessage = TextEditingController();
  // File _image;
  // final _formKey = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Add Assignment'),
      // ),
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
                                      .sendAssignmentData(
                                          isHomeWOrk: true,
                                          attachement: _file,
                                          classId: classSectionProvder
                                              .classModel.classId,
                                          sectionId: classSectionProvder
                                              .sectionModel.sectionId,
                                          fileName: _file != null
                                              ? p.basename(_file.path)
                                              : "",
                                          message: _controllerMessage.text,
                                          subject: _controllerSubject.text,
                                          teacherId: widget.teacherId,
                                          fileExtension: fileExtension ?? "");
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
}

//  Form(
//         child: Container(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: TextFormField(
//                   // validator: (value) => value.isEmpty ? "Enter Image Url "  ,
//                   decoration: InputDecoration(
//                     hintText: 'Assignment Image Url (Optional)',
//                   ),
//                   controller: _imageController,
//                 ),
//               ),
//               SizedBox(height: 7),
//               Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: TextFormField(
//                   // validator: (value) => value.isEmpty ? "Enter Image Url "  ,
//                   decoration: InputDecoration(
//                     hintText: 'Assignment Title',
//                   ),
//                   controller: _titleController,
//                 ),
//               ),
//               SizedBox(height: 7),
//               Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: TextFormField(
//                   // validator: (value) => value.isEmpty ? "Enter Image Url "  ,
//                   decoration: InputDecoration(
//                     hintText: 'Assignment Description ',
//                   ),
//                   controller: _descriptionController,
//                 ),
//               ),
//               Spacer(),

//               // SizedBox(height: 7),
//               RaisedButton(
//                 color: Colors.blue,
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Text(
//                     'Create Assignment',
//                     style: TextStyle(
//                       color: Colors.white,
//                       //  fontSize: 20
//                     ),
//                   ),
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25.0),
//                   // side: BorderSide(color: Colors.red)
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => AddQuestions(),
//                   ));
//                 },
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
