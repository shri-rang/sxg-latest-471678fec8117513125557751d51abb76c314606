import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/chooseInboxSent.dart';
import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/teacherProfile.dart';
import 'package:simple_x_genius/UI/pages/allcategorisofStudent/elearning.dart';
import 'package:simple_x_genius/UI/pages/allcategorisofStudent/gallarypage.dart';
import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/salaryslip.dart';
import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/timetable.dart';
import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/addmarks.dart';
import 'package:simple_x_genius/UI/pages/customarecare/customerCare.dart';
import 'package:simple_x_genius/UI/pages/password/changePassword.dart';
import 'package:simple_x_genius/UI/pages/studentCircular/studentCircularList.dart';
import 'package:simple_x_genius/UI/widget/categoryCardWidget.dart';
import 'package:simple_x_genius/UI/widget/errorDialougeWidget.dart';
import 'package:simple_x_genius/UI/widget/futureBuilderWidget.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/api/userTokenProvider.dart';
import 'package:simple_x_genius/model/constantCategoryDataModel.dart';
import 'package:simple_x_genius/model/teacherInfoModel.dart';
import 'package:simple_x_genius/utility/tokenStoreUtil.dart';
import 'package:simple_x_genius/constant/registerNotification.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTeacherPage extends StatefulWidget {
  final List<String> teacherInfo;

  const HomeTeacherPage({Key key, this.teacherInfo}) : super(key: key);
  @override
  _HomeTeacherPageState createState() => _HomeTeacherPageState();
}

class _HomeTeacherPageState extends State<HomeTeacherPage> {
  NetWorkAPiRepository _netWorkAPiRepository;
  CategoryDataSource _constantDataSource;

//     _launchURL() async {
//    const url = 'https://www.simplexgenius.in/theduncanacademy_Elearn/elearn/Login';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

  @override
  void initState() {
    _netWorkAPiRepository = NetWorkAPiRepository();
    _constantDataSource = CategoryDataSource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userTokendata = Provider.of<UserTokenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              buildAlertDialog(context, () async {
                await StorageUtil.removeString('userInfo');
                await userTokendata.removeUserToken('token');
                Navigator.of(context).pop();
              });
            },
          )
        ],
      ),
      body: FutureBuilderWidget<TeacherInfoModel>(
        future: _netWorkAPiRepository
            .getTeacherInfoDataModel(widget.teacherInfo[2]),
        builder: (context, profileData) => profileData == null
            ? Center(child: Text("No internet connection"))
            : Container(
                margin: EdgeInsets.symmetric(vertical: 15.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: _constantDataSource.categoryNameForTeacher.length,
                  itemBuilder: (context, index) {
                    return CategoryCardWidget(
                      onTap: () {
                        if (index == 0)
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => Provider<TeacherInfoModel>(
                                    child: TeacherProfilePage(),
                                    create: (BuildContext context) =>
                                        profileData,
                                  )));
                        if (index == 1)
                          Navigator.of(context)
                              .pushNamed('/getClassSectionPage');
                        if (index == 2)
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => Elearning()));
                        if (index == 3)
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ChooseOptionByTeacher(
                                    uitype: UIType.HomeWOrk,
                                    teacherId: profileData.teacherId,
                                  )));
                        if (index == 4)
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => StudentCircularList(
                                    isTeacher: true,
                                    uitype: UIType.Circualr,
                                    id: profileData.teacherId,
                                    // studentInfoModel: widget.studentInfoModel,
                                  )));

                        if (index == 5)
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ChooseOptionByTeacher(
                                    uitype: UIType.DairyNotes,
                                    teacherId: profileData.teacherId,
                                  )));

                        // if (index == 5)
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (_) => InboxInfo(
                        //             uid: profileData.teacherId,
                        //           )));
                        if (index == 6)
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => AddMarks(
                                    id: profileData.teacherId,
                                  )));
                        if (index == 7)
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => SalarySlip(
                                    id: profileData.teacherId,
                                  )));

                        if (index == 8)
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  TimeTable(id: profileData.teacherId)));
                        if (index == 9)
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ChangePassWord(
                                    phoneNumber: profileData.phone,
                                    isTeacher: true,
                                  )));
                        if (index == 10)
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => CustomerCare(
                                    phoneNumber: "918310361527",
                                    isTeacher: true,
                                  )));
                        if (index == 11)
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => Gallarypage()));
                      },
                      icon: _constantDataSource.iconSrcForTeacher[index],
                      title: _constantDataSource.categoryNameForTeacher[index],
                    );
                  },
                ),
              ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: defaultAppBlueColor,
      //     mini: true,0
      //     child: Icon(Icons.power_settings_new),
      //     onPressed: () async {
      //       await StorageUtil.removeString('userInfo');
      //       await userTokendata.removeUserToken('token');
      //     }),
    );
  }
}
