import 'package:flutter/material.dart';
import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/chooseInboxSent.dart';
import 'package:simple_x_genius/UI/pages/studentCircular/studentCircularDetails.dart';
import 'package:simple_x_genius/UI/widget/futureBuilderWidget.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/constant/colors.dart';
import 'package:simple_x_genius/model/circularStudenModel.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';
import 'package:intl/intl.dart';

class StudentCircularList extends StatefulWidget {
  final StudentInfoModel studentInfoModel;
  final String id;
  final UIType uitype;
  final bool isTeacher;

  const StudentCircularList(
      {Key key,
      this.studentInfoModel,
      @required this.isTeacher,
      this.id,
      @required this.uitype})
      : super(key: key);
  @override
  _StudentCircularListState createState() => _StudentCircularListState();
}

class _StudentCircularListState extends State<StudentCircularList> {
  NetWorkAPiRepository _netWorkAPiRepository;
  DateFormat format = DateFormat("yyyy-MM-dd");
  @override
  void initState() {
    _netWorkAPiRepository = NetWorkAPiRepository();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          widget.uitype == UIType.HomeWOrk
              ? "HomeWork"
              : widget.uitype == UIType.Circualr
                  ? "Circular"
                  : widget.uitype == UIType.DairyNotes ? "DiaryNotes" : "",
          style: TextStyle(color: blackColor),
        ),
        iconTheme: IconThemeData(color: blackColor),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: FutureBuilderWidget<List<CircularStudentModel>>(
          future:
              //  widget.teacherId != null
              //     ?
              _netWorkAPiRepository.getHWCricularDNoteListByDataModel(
                  widget.id, widget.isTeacher,
                  uitype: widget.uitype),
          // : _netWorkAPiRepository.getStudentCircularDataModel(
          //     widget.studentInfoModel.studenId),
          builder: (context, circularData) {
            if (circularData == null) return Container();
            if (circularData.isEmpty)
              return Center(
                child: Text("No Data found"),
              );
            circularData.sort((a, b) => format
                .parse(b.notifyTime)
                .compareTo(format.parse(a.notifyTime)));
            return SingleChildScrollView(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Subject')),
                    DataColumn(label: Text('Message')),
                    DataColumn(label: Text('Date/Time')),
                  ],
                  rows: circularData
                      .map((data) => DataRow(
                            cells: [
                              DataCell(
                                  Text(
                                    data.title,
                                    style: TextStyle(
                                        color: data.readStatus == "0"
                                            ? blueColor
                                            : data.readStatus == "1"
                                                ? greyColor
                                                : blackColor),
                                  ), onTap: () {
                                handleOntap(
                                  data,
                                );
                              }),
                              DataCell(
                                  Text(
                                      data.message.length > 10
                                          ? data.message.substring(0, 10)
                                          : data.message,
                                      style: TextStyle(
                                          color: data.readStatus == "0"
                                              ? blueColor
                                              : data.readStatus == "1"
                                                  ? greyColor
                                                  : blackColor)), onTap: () {
                                handleOntap(data);
                              }),
                              DataCell(
                                  Text(data.notifyTime,
                                      style: TextStyle(
                                          color: data.readStatus == "0"
                                              ? blueColor
                                              : data.readStatus == "1"
                                                  ? greyColor
                                                  : blackColor)), onTap: () {
                                handleOntap(data);
                              }),
                            ],
                          ))
                      .toList(),
                ),
              ),
            );
          }),
    );
  }

  handleOntap(CircularStudentModel circularStudentModel) {
    if (widget.uitype != UIType.Circualr) {
      //for homework and diarynotes
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StudentCircularDetails(
                messageId: circularStudentModel.messageId,
                readStatus: circularStudentModel.readStatus,
                viewType: widget.uitype,
                isTeacher: widget.isTeacher,
                uid: widget.id,
              )));
    } else {
      //for circular
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StudentCircularDetails(
                messageId: circularStudentModel.messageId,
                readStatus: circularStudentModel.readStatus,
                viewType: widget.uitype,
                isTeacher: widget.isTeacher,
                circularStudentModel: circularStudentModel,
                uid: widget.id,
              )));
    }
  }
}
