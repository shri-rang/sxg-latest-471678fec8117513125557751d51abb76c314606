import 'package:flutter/material.dart';
import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/chooseInboxSent.dart';
import 'package:simple_x_genius/UI/pages/allcategorisofStudent/assignment/assignmentPage.dart';
import 'package:simple_x_genius/UI/pages/allcategorisofStudent/attendancePage.dart';
import 'package:simple_x_genius/UI/pages/allcategorisofStudent/elearning.dart';
import 'package:simple_x_genius/UI/pages/allcategorisofStudent/feesinvoice.dart';
import 'package:simple_x_genius/UI/pages/allcategorisofStudent/parentDetailsPage.dart';
import 'package:simple_x_genius/UI/pages/allcategorisofStudent/studentDetails.dart';
import 'package:simple_x_genius/UI/pages/password/changePassword.dart';
import 'package:simple_x_genius/UI/pages/reportcard/reportCard.dart';
import 'package:simple_x_genius/UI/pages/customarecare/customerCare.dart';
import 'package:simple_x_genius/UI/pages/reportcard/termRerpportCard.dart';
import 'package:simple_x_genius/UI/pages/studentCircular/studentCircularList.dart';
import 'package:simple_x_genius/UI/widget/categoryCardWidget.dart';
import 'package:simple_x_genius/model/constantCategoryDataModel.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_x_genius/UI/pages/allcategorisofStudent/liveclass/liveclass.dart';
import './contactscreen.dart';
import './gallarypage.dart';

class CategoryListPage extends StatefulWidget {
  final StudentInfoModel studentInfoModel;
  final String id;
  final String phone;

  const CategoryListPage(
      {Key key, this.studentInfoModel, this.phone, @required this.id})
      : super(key: key);
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  CategoryDataSource _constantDataSource;
  @override
  void initState() {
    _constantDataSource = CategoryDataSource();
    super.initState();
  }

  _launchURL() async {
    const url =
        'https://www.simplexgenius.in/theduncanacademy_Elearn/elearn/Login';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 500,
      // child:
      //  Center(
      //   child: RaisedButton(
      //     onPressed: () {
      //       print(widget.studentInfoModel.parentId);
      //     },
      //   ),
      // ),
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: _constantDataSource.categoryName.length,
        itemBuilder: (context, index) {
          return CategoryCardWidget(
            onTap: () {
              if (index == 0)
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => StudentDetails(
                          studentInfoModel: widget.studentInfoModel,
                        )));
              if (index == 1)
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ParentDetailsPage(
                          studentInfoModel: widget.studentInfoModel,
                          id: widget.id,
                        )));

              if (index == 2)
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Elearning()));

              if (index == 3)
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => AttendancePage(
                          studentInfoModel: widget.studentInfoModel,
                        )));

              //homework

              if (index == 4)
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => StudentCircularList(
                          isTeacher: false,
                          uitype: UIType.HomeWOrk,
                          id: widget.id,
                          studentInfoModel: widget.studentInfoModel,
                        )));

              //circular
              if (index == 5)
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => StudentCircularList(
                          isTeacher: false,
                          id: widget.id,
                          studentInfoModel: widget.studentInfoModel,
                          uitype: UIType.Circualr,
                        )));

              //diary notes
              if (index == 6)
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => StudentCircularList(
                          isTeacher: false,
                          uitype: UIType.DairyNotes,
                          id: widget.id,
                          studentInfoModel: widget.studentInfoModel,
                        )));
              //  if(index==7 )Navigator.of(context).pushNamed('/newsLetterPage');

              if (index == 7)
                //  _launchURL();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => AssignmentPage(
                          studentInfoModel: widget.studentInfoModel,
                        )));

              if (index == 8)
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => LiveClasses(
                          studentInfoModel: widget.studentInfoModel,
                          // id: widget.id,
                        )));
              if (index == 9)
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => FeesInvoice(
                          // studentInfoModel: widget.studentInfoModel,
                          id: widget.id,
                        )));
              if (index == 10)
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ChangePassWord(
                          phoneNumber: widget.phone,
                          isTeacher: false,
                        )));
              if (index == 11)
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CustomerCare(
                          phoneNumber: "917992239925",
                          isTeacher: false,
                        )));
              if (index == 12)
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ContactScreen(
                        // phoneNumber: "917992239925",
                        // isTeacher: false,
                        )));
              // if (index == 9)
              //   // Navigator.of(context).push(MaterialPageRoute(
              //   //     builder: (_) => TermReportCard(
              //   //           // phoneNumber: "918310361527",
              //   //           // isTeacher: false,
              //   //           id: widget.id,
              //   //         ))
              //           // );
            },
            icon: _constantDataSource.iconSrc[index],
            title: _constantDataSource.categoryName[index],
          );
        },
      ),
    );
  }
}
