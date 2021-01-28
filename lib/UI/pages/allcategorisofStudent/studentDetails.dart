import 'package:flutter/material.dart';
import 'package:simple_x_genius/UI/widget/customAppBarProfile.dart';
import 'package:simple_x_genius/UI/widget/futureBuilderWidget.dart';
import 'package:simple_x_genius/UI/widget/infoTileWidget.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/constant/colors.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';

class StudentDetails extends StatefulWidget {
  final StudentInfoModel studentInfoModel;

  const StudentDetails({Key key, this.studentInfoModel}) : super(key: key);
  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  NetWorkAPiRepository _netWorkAPiRepository;
  @override
  void initState() {
    _netWorkAPiRepository = NetWorkAPiRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.studentInfoModel.photo);
    return Scaffold(
      appBar: customAppBarProfileone(
          backTap: () {
            Navigator.of(context).pop();
          },
          imageUrl: widget.studentInfoModel.photo),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Student Information",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: blackColor.withOpacity(0.8),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  InfoTileWIdget(
                      title: "Student Name",
                      value: widget.studentInfoModel.studenName),

                  InfoTileWIdget(
                      title: "Roll No", value: widget.studentInfoModel.roll),
                  FutureBuilderWidget<String>(
                    loadingIndicator: Container(),
                    future: _netWorkAPiRepository.getClassNameDataModel(
                        widget.studentInfoModel.classesID),
                    builder: (context, data) =>
                        InfoTileWIdget(title: "Class", value: data),
                  ),
                  FutureBuilderWidget<String>(
                    loadingIndicator: Container(),
                    future: _netWorkAPiRepository.getStudentSectionData(
                        widget.studentInfoModel.sectionID),
                    builder: (context, data) {
                      return InfoTileWIdget(title: "Section", value: data);
                    },
                  ),
                  InfoTileWIdget(
                      title: "Addmission No",
                      value: widget.studentInfoModel.admNo),
                  InfoTileWIdget(
                      title: "Date of Birth",
                      value: widget.studentInfoModel.dob),
                  InfoTileWIdget(
                      title: "Address", value: widget.studentInfoModel.address),

                  InfoTileWIdget(
                      title: "Blood Group",
                      value: widget.studentInfoModel.blood),
                  InfoTileWIdget(
                      title: "Aadhar No",
                      value: widget.studentInfoModel.adharNo),
                  InfoTileWIdget(
                      title: "Gender", value: widget.studentInfoModel.sex),

                  SizedBox(
                    height: 20.0,
                  ),
                  // SizedBox(
                  //   height: 50.0,
                  //   width: double.infinity,
                  //   child: RaisedButton(
                  //       color: defaultAppBlueColor,
                  //       child: Text("UPDATE"),
                  //       textColor: whiteColor,
                  //       onPressed: () {}),
                  // ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
