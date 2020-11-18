import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_x_genius/constant/colors.dart';
import 'package:simple_x_genius/model/attenDatePassDataModel.dart';
import 'package:simple_x_genius/model/classModel.dart';
import 'package:simple_x_genius/model/sectionModel.dart';
import 'package:table_calendar/table_calendar.dart';

import 'getClassSectionProvider.dart';

class GetClassAndSectionPage extends StatefulWidget {
  @override
  _GetClassAndSectionPageState createState() => _GetClassAndSectionPageState();
}

class _GetClassAndSectionPageState extends State<GetClassAndSectionPage> {
  CalendarController _calendarController;
  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<GetClassSectionProvider>(context, listen: false)
        .getClassDataModelProvider();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          "Student Attendace",
          style: TextStyle(color: blackColor),
        ),
        iconTheme: IconThemeData(color: blackColor),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 35.0),
          child: Consumer<GetClassSectionProvider>(
            builder: (context, classSectionProvider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: Text(
                    "Class",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton<ClassModel>(
                  hint: Text(classSectionProvider.classModel == null
                      ? "please select a class"
                      : classSectionProvider.classModel.className),
                  isExpanded: true,
                  items: classSectionProvider.classModels.map((value) {
                    return new DropdownMenuItem<ClassModel>(
                      value: value,
                      child: new Text(value.className),
                    );
                  }).toList(),
                  onChanged: (value) {
                    print(value.classId);
                  print(value.classNumeric);
                    classSectionProvider.classModel = value;
                    classSectionProvider.sectionModel = null;
                    classSectionProvider
                        .getSectionDataModelProvider(value.classId);
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: Text(
                    "Section",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                classSectionProvider.loaderState
                    ? Container(
                        child: Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text("Fetching section...")))
                    : DropdownButton<SectionModel>(
                        hint: Text(classSectionProvider.sectionModel == null
                            ? "please select a section"
                            : classSectionProvider.sectionModel.sectionName),
                        isExpanded: true,
                        items: classSectionProvider.sectionModels.map((value) {
                          return new DropdownMenuItem<SectionModel>(
                            value: value,
                            child: new Text(value.sectionName),
                          );
                        }).toList(),
                        onChanged: (value) {
                          classSectionProvider.sectionModel = value;

                          print(value.sectionId);
                        },
                      ),
                SizedBox(
                  height: 15.0,
                ),
                TableCalendar(calendarController: _calendarController),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: RaisedButton(
                      color: blueColor,
                      textColor: whiteColor,
                      child: Text("Continue"),
                      onPressed: () {
                        if (classSectionProvider.sectionModel.classId != null &&
                            classSectionProvider.sectionModel.sectionId !=
                                null) {
                          Navigator.of(context).pushNamed('/setAttandencePage',
                              arguments: AttendencePassAbleDataModel(
                                  classId:
                                      classSectionProvider.classModel.classId,
                                  sectionId: classSectionProvider
                                      .sectionModel.sectionId,
                                  date: 
                                          _calendarController.selectedDay.day.toString()   +
                                      "-" +
                                      dayMonthFormatter(_calendarController
                                          .selectedDay.month) +
                                      "-" +
                                      _calendarController.selectedDay.year
                                          .toString()));
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String dayMonthFormatter(v) =>
      v < 10 ? v.toString().padLeft(2, '0') : v.toString();

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }
}
