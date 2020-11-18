import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_x_genius/constant/colors.dart';
import 'package:simple_x_genius/model/attenDatePassDataModel.dart';

import 'setAttendanceProvider.dart';

class SetAttandencePage extends StatefulWidget {
  final AttendencePassAbleDataModel passAbleDataModel;

  const SetAttandencePage({Key key, this.passAbleDataModel}) : super(key: key);
  @override
  _SetAttandencePageState createState() => _SetAttandencePageState();
}

class _SetAttandencePageState extends State<SetAttandencePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // Provider.of<SetattendencePovider>(context, listen: false)
    //     .getStudentListOfASection(widget.passAbleDataModel.classId,
    //         widget.passAbleDataModel.sectionId);
    Provider.of<SetattendencePovider>(context, listen: false)
        .getAttendanceOfAllStudent(
            classId: widget.passAbleDataModel.classId,
            month: widget.passAbleDataModel.date,
            secttionID: widget.passAbleDataModel.sectionId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var attendanceProvider = Provider.of<SetattendencePovider>(
      context,
    );

    return WillPopScope(
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: whiteColor,
          appBar: AppBar(
            backgroundColor: whiteColor,
            title: Text(
              "Student Attendace",
              style: TextStyle(color: blackColor),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: blackColor),
              onPressed: () {
                attendanceProvider.clearAllSelcetion();
                Navigator.of(context).pop();
              },
            ),
            actions: <Widget>[
              attendanceProvider.loaderState
                  ? Container(
                      child: Container(
                          margin: EdgeInsets.only(right: 10.0),
                          child: CupertinoActivityIndicator(
                            radius: 15.0,
                          )))
                  : Container()
            ],
            // iconTheme: IconThemeData(color: blackColor),
            centerTitle: true,
            elevation: 0.0,
          ),
          body: Consumer<SetattendencePovider>(
              builder: (_, attendanceProvider, child) {
            // if (attendanceProvider.attendanceSubmissionResult.isNotEmpty) {

            //     WidgetsBinding.instance.addPostFrameCallback((_) =>
            //         _showErrorMessage(
            //             attendanceProvider.attendanceSubmissionResult,
            //             Duration(seconds: 2)));

            //   }

            if (attendanceProvider.attendaneceStudentAllData.isNotEmpty) {
              attendanceProvider.attendaneceStudentAllData.sort((a, b) =>
                  a.name.toLowerCase().compareTo(b.name.toLowerCase()));
              return IgnorePointer(
                ignoring: attendanceProvider.loaderState,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          horizontalMargin: 10.0,
                          columnSpacing: 5.0,
                            columns: [
                              DataColumn(label: Text("Name")),
                              DataColumn(label: Text("Roll")),
                              DataColumn(
                                  label: Row(
                                children: <Widget>[
                                  SizedBox(
                                    height: 24.0,
                                    width: 24.0,
                                    child: Checkbox(
                                        value: attendanceProvider
                                            .allFullDayaSelction,
                                        onChanged: (v) async {
                                          if (v) {
                                            setAttendanceToAllFunction(
                                                attendanceProvider, "P");
                                          } else {
                                            setAttendanceToAllFunction(
                                                attendanceProvider, "A");
                                          }
                                        }),
                                  ),
                                  Text("Full Day")
                                ],
                              )),
                              //half day
                              DataColumn(
                                  label: Row(
                                children: <Widget>[
                                  SizedBox(
                                    height: 24.0,
                                    width: 24.0,

                                                                      child: Checkbox(
                                        value: attendanceProvider
                                            .allHalfDayaSelction,
                                        onChanged: (v) {
                                          if (v) {
                                            setAttendanceToAllFunction(
                                                attendanceProvider, "H");
                                          } else {
                                            attendanceProvider
                                                .allHalfDayaSelction = v;
                                            setAttendanceToAllFunction(
                                                attendanceProvider, "A");
                                          }
                                        }),
                                  ),
                                  Text("Half Day")
                                ],
                              )),

                              //school holiday
                              DataColumn(
                                  label: Row(
                                children: <Widget>[
                                  SizedBox(
                                    height: 24.0,
                                    width: 24.0,
                                                                      child: Checkbox(
                                        value: attendanceProvider
                                            .allSchoolHolidaySelection,
                                        onChanged: (v) {
                                          if (v) {
                                            setAttendanceToAllFunction(
                                                attendanceProvider, "SH");
                                          } else {}
                                        }),
                                  ),
                                  Text("School Holiday")
                                ],
                              ))
                            ],
                            rows: attendanceProvider.attendaneceStudentAllData
                                .map((stuData) {
                              // int index = attendanceProvider
                              //     .attendaneceStudentAllData
                              //     .indexOf(stuData);

                              return DataRow(cells: [
                                DataCell(Text(stuData.name.length > 13
                                    ? stuData.name.toString().substring(0, 13)
                                    : stuData.name)),
                                DataCell(Text(stuData.roll)),
                                //full day
                                DataCell(SizedBox(
                                  height: 24.0,
                                    width: 24.0,
                                                                  child: Checkbox(
                                    value: stuData.attendance.toString() == "P"
                                        ? true
                                        : false,
                                    onChanged: (v) {
                                      setAttendanceToSingleStudentFunction(
                                          attendanceProvider,
                                          stuData.studentID,
                                          v ? "P" : "A");
                                    },
                                  ),
                                )),

                                //half day
                                DataCell(SizedBox(
                                                  height: 24.0,
                                    width: 24.0,                child: Checkbox(
                                    value: stuData.attendance.toString() == 'H'
                                        ? true
                                        : false,
                                    onChanged: (v) {
                                   
                                        setAttendanceToSingleStudentFunction(
                                            attendanceProvider,
                                            stuData.studentID,
                                            v ? "H" : "A");
                                    },
                                  ),
                                )),

                                //holiday
                                DataCell(SizedBox(
                                  height: 24.0,
                                    width: 24.0,

                                                                  child: Checkbox(
                                    value: stuData.attendance.toString() == 'SH'
                                        ? true
                                        : false,
                                    onChanged: (v) {},
                                  ),
                                ))
                              ]);
                            }).toList()),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          })),
      onWillPop: () async {
        attendanceProvider.clearAllSelcetion();
        return true;
      },
    );
  }

  void setAttendanceToAllFunction(
      SetattendencePovider attendanceProvider, String attendance) async {
    var response = await attendanceProvider.setAttendanceToAllProvider(
      attendance: attendance,
      classId: widget.passAbleDataModel.classId,
      date: widget.passAbleDataModel.date,
      sectionId: widget.passAbleDataModel.sectionId,
    );
    attendanceProvider.getAttendanceOfAllStudent(
        classId: widget.passAbleDataModel.classId,
        month: widget.passAbleDataModel.date,
        secttionID: widget.passAbleDataModel.sectionId);
    _showSnackbarMessage(response);
  }

  void setAttendanceToSingleStudentFunction(
      SetattendencePovider attendanceProvider,
      String studentId,
      String attendance) async {
    var response =
        await attendanceProvider.setAttendanceToSingleStudentProvider(
      attendance: attendance,
      classId: widget.passAbleDataModel.classId,
      date: widget.passAbleDataModel.date,
      studentId: studentId,
      sectionId: widget.passAbleDataModel.sectionId,
    );

    attendanceProvider.getAttendanceOfAllStudent(
        classId: widget.passAbleDataModel.classId,
        month: widget.passAbleDataModel.date,
        secttionID: widget.passAbleDataModel.sectionId);

    _showSnackbarMessage(response);
  }

  void _showSnackbarMessage(bool response) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: response ? greenColor : redColor,
      content: Text(response
          ? "Attendance Submitted successfully"
          : "Attendance submission failed"),
      duration: Duration(seconds: 2),
    )
    );
  }
}