import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/addquestion.dart';
import 'dart:io';
import 'package:intl/intl.dart';
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
import 'package:simple_x_genius/model/subjectmodel.dart';
import './date.dart';

class AddClasses extends StatefulWidget {
  final String id;

  AddClasses({this.id});
  @override
  _AddClassesState createState() => _AddClassesState();
}

class _AddClassesState extends State<AddClasses> {
  NetWorkAPiRepository _netWorkAPiRepository;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _netWorkAPiRepository = NetWorkAPiRepository();
    var data = Provider.of<GetClassSectionProvider>(context, listen: false);
    data.getClassDataModelProvider();
    // data.getSubjetDataModelProvider();
    joinTime = TimeOfDay.now();
    endTime = TimeOfDay.now();
  }

  //  final dateTime = endTime.applied();

  final _formKey = GlobalKey<FormState>();
  TimeOfDay joinTime;
  TimeOfDay endTime;
  DateTime selectedDate = DateTime.now();
  TextEditingController _datecontroller = TextEditingController();
  TextEditingController _subcontroller = TextEditingController();
  // TextEditingController _date = new TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    //  final DateTime convertedDate = new DateFormat("yyyy-MM-dd").format(picked);
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        final String convertedDate =
            new DateFormat("yyyy-MM-d").format(selectedDate);
        _datecontroller.value = TextEditingValue(text: convertedDate);
      });
  }

  _joinTime() async {
    TimeOfDay t = await showTimePicker(context: context, initialTime: joinTime);
    int hour;
    int minute;
    // t.replacing(int hour; int minute;  );
    // t.replacing()

    if (t != null)
      setState(() {
        joinTime = t;
      });
  }

  _endTime() async {
    TimeOfDay t = await showTimePicker(
        context: context,
        initialTime: endTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });

    // );
    if (t != null)
      setState(() {
        endTime = t;
      });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    final formattedTimeOfDay =
        localizations.formatTimeOfDay(joinTime, alwaysUse24HourFormat: true);
    final formattedEndDate =
        localizations.formatTimeOfDay(endTime, alwaysUse24HourFormat: true);
    return Scaffold(
        appBar: AppBar(title: Text('Add Classes')),
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
                            classSectionProvder
                                .getSubjetDataModelProvider(value.classId);
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
                                hint: Text(
                                    classSectionProvder.sectionModel == null
                                        ? "please select a section"
                                        : classSectionProvder
                                            .sectionModel.sectionName),
                                isExpanded: true,
                                items: classSectionProvder.sectionModels
                                    .map((value) {
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
                          height: 10.0,
                        ),
                        Container(
                          child: Text(
                            "Subject",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        classSectionProvder.loaderState
                            ? Container(
                                child: Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    child: Text("Fetching section...")))
                            : DropdownButton<SubjectModel>(
                                hint: Text(classSectionProvder.subjectModel ==
                                        null
                                    ? "please select a subject"
                                    : classSectionProvder.subjectModel.subject),
                                isExpanded: true,
                                items: classSectionProvder.subjectModels
                                    .map((value) {
                                  return new DropdownMenuItem<SubjectModel>(
                                    value: value,
                                    child: new Text(value.subject),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  classSectionProvder.subjectModel = value;
                                  print(classSectionProvder
                                      .subjectModel.subjectId);
                                },
                              ),
                        // Padding(
                        //   padding: EdgeInsets.all(10),
                        //   child: TextFormField(
                        //     controller: _subcontroller,
                        //     textCapitalization: TextCapitalization.sentences,
                        //     // keyboardType: TextIn,
                        //     validator: (value) {
                        //       if (value.isEmpty) {
                        //         return 'Please enter some text';
                        //       }
                        //       return null;
                        //     },

                        //     // controller: _namecontroller,
                        //     decoration: InputDecoration(
                        //       border: OutlineInputBorder(),
                        //       labelText: 'Enter Subject',
                        //       hintText: 'Enter subject',
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () => _selectDate(context),
                            child: AbsorbPointer(
                              child: TextField(
                                keyboardType: TextInputType.datetime,
                                controller: _datecontroller,
                                // onTap: () {
                                //   // _selectDate(context);
                                //   // showDatePicker(
                                //   //   context: context,
                                //   //   initialDate: DateTime.now(),
                                //   //   firstDate: DateTime(2000), // Required
                                //   //   lastDate: DateTime(2025), // Required
                                //   // );
                                // },
                                // obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  // labelText: 'Password',
                                  hintText: 'Date',
                                  // suffixIcon: ,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                              "Jion Time: ${joinTime.hour}:${joinTime.minute}"),
                          trailing: Icon(Icons.keyboard_arrow_down),
                          onTap: _joinTime,
                        ),
                        ListTile(
                          title: Text(
                              "End Time: ${endTime.hour}:${endTime.minute}"),
                          trailing: Icon(Icons.keyboard_arrow_down),
                          onTap: _endTime,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: RaisedButton.icon(
                            color: Colors.blue,
                            label: Text(
                              'Add Class',
                              style: TextStyle(color: Colors.white),
                            ),
                            icon: Icon(
                              Icons.videocam,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _netWorkAPiRepository.classesAdd(
                                date: _datecontroller.text.toString(),
                                classes: classSectionProvder.classModel.classId,
                                sectionId:
                                    classSectionProvder.sectionModel.sectionId,
                                subject:
                                    classSectionProvder.subjectModel.subjectId,
                                jointime: formattedTimeOfDay,
                                teacherId: widget.id.toString(),
                                endtime: formattedEndDate,
                                // print()
                              );
                              // Navigator.canPop(context);
                              Navigator.of(context).pop();
                              // _launchURL();
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              // side: BorderSide(color: Colors.red)
                            ),
                          ),
                        ),
                        // Text(endTime.toString()),
                        // RaisedButton(
                        //   onPressed: () {
                        //     print(formattedTimeOfDay);

                        //     // print(endTime.format(context));
                        //   },
                        // )
                      ]))));
        }));
  }
}
