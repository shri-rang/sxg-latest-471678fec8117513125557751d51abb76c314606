import 'package:flutter/material.dart';
import 'package:simple_x_genius/UI/widget/presentAbsentIndicator.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/constant/colors.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendancePage extends StatefulWidget {
  final StudentInfoModel studentInfoModel;

  const AttendancePage({Key key, this.studentInfoModel}) : super(key: key);
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  CalendarController _calendarController;
  //String name = "Abdullah";
  DateTime attendanceMonthYear;
  NetWorkAPiRepository _netWorkAPiRepository;
  @override
  void initState() {
    _calendarController = CalendarController();
    _netWorkAPiRepository = NetWorkAPiRepository();
    attendanceMonthYear = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          "Attendance",
          style: TextStyle(color: blackColor),
        ),
        iconTheme: IconThemeData(color: blackColor),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Student",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, style: BorderStyle.solid),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    child: DropdownButtonHideUnderline(
                      // child: DropdownButton<String>(
                      //   isExpanded: true,
                      //   value: name,
                      //   items: <String>['Abdullah', 'Bijoy', 'Sabbir']
                      //       .map((String value) {
                      //     return new DropdownMenuItem<String>(
                      //       value: value,
                      //       child: new Text(value),
                      //     );
                      //   }).toList(),
                      //   onChanged: (_) {},
                      // ),
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        child: Text(
                          widget.studentInfoModel.studenName,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FutureBuilder(
                    future: _netWorkAPiRepository.getStudentAttendanceModel(
                        widget.studentInfoModel.studenId,
                        "${attendanceMonthYear.month < 10 ? attendanceMonthYear.month.toString().padLeft(2, '0') : attendanceMonthYear.month}-${attendanceMonthYear.year}"),
                    builder: (_, data) {
                      return TableCalendar(
                        locale: 'en_US',
                        weekendDays: [DateTime.sunday],
                        daysOfWeekStyle: DaysOfWeekStyle(),
                        calendarController: _calendarController,
                        headerStyle: HeaderStyle(),
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false,
                          holidayStyle: TextStyle().copyWith(color: greyColor),
                        ),
                        onVisibleDaysChanged: (datetime, datetime2, format) {
                          setState(() {
                            attendanceMonthYear = datetime;
                          });
                        },
                        builders:
                            CalendarBuilders(dayBuilder: (context, date, _) {
                          //  if (data.hasData)
                          //    print(data.data["a" + date.day.toString()]);

                          return data.hasData
                              ? Container(
                                  margin: EdgeInsets.all(4.0),
                                  color: date.weekday == DateTime.sunday
                                      ? greyColor.withOpacity(0.7)
                                      : getDayColor(data, date),
                                  child: Center(
                                    child: Text(date.day.toString()),
                                  ),
                                )
                              : Container();
                        }, todayDayBuilder: (context, date, _) {
                          return Container(
                            margin: EdgeInsets.all(4.0),
                            color: data.hasData
                                ? getDayColor(data, date)
                                : Colors.transparent,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: blueColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(date.day.toString()),
                                ),
                              ),
                            ),
                          );
                        }),
                        //  events: ,
                      );
                    }),
                SizedBox(
                  height: 10.0,
                ),
                PresentAbsentIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getDayColor(data, date) {
    return data.data["a" + date.day.toString()] == "H"
        ? yellowColor
        : data.data["a" + date.day.toString()] == "A"
            ? redColor
            : data.data["a" + date.day.toString()] == "P"
                ? greenColor
                : data.data["a" + date.day.toString()] == "SH"
                    ? orangeColor
                    : Colors.transparent;
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }
}
