import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_x_genius/UI/pages/allcategorisofStudent/categoryListPage.dart';
import 'package:simple_x_genius/UI/widget/errorDialougeWidget.dart';
import 'package:simple_x_genius/UI/widget/futureBuilderWidget.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/api/userTokenProvider.dart';
import 'package:simple_x_genius/constant/firebasecontroller.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';
import 'package:simple_x_genius/utility/tokenStoreUtil.dart';
import 'package:simple_x_genius/constant/registerNotification.dart';

class HomeParentPage extends StatefulWidget {
  final List<String> parentInfo;
  //  FirebaseMessaging firebaseMessaging;

  const HomeParentPage({Key key, this.parentInfo}) : super(key: key);
  @override
  _HomeParentPageState createState() => _HomeParentPageState();
}

class _HomeParentPageState extends State<HomeParentPage> {
  NetWorkAPiRepository _netWorkAPiRepository;

  @override
  void initState() {
    _netWorkAPiRepository = NetWorkAPiRepository();
    // print(widget.parentInfo[0]);
    // print(widget.parentInfo[1]);
    // print(widget.parentInfo[2]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userTokendata = Provider.of<UserTokenProvider>(context, listen: false);
    return Scaffold(
      body: FutureBuilderWidget<List<StudentInfoModel>>(
          future:
              _netWorkAPiRepository.getStudentDataRepo(widget.parentInfo[2]),
          builder: (context, snapshot) {
            if (snapshot == null)
              return Center(
                child: Text("No internet connection"),
              );
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: DefaultTabController(
                  length: snapshot.length,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text("Parent"),
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
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(40),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TabBar(
                            isScrollable: true,
                            tabs: snapshot
                                .map((i) => Tab(
                                      text: i.studenName.length > 5
                                          ? i.studenName.substring(0, 5)
                                          : i.studenName,
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),

                    body: new TabBarView(
                        children: snapshot
                            .map((studentInfo) => Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: CategoryListPage(
                                  id: studentInfo.studenId,
                                  phone: widget.parentInfo[2],
                                  studentInfoModel: studentInfo,
                                )))
                            .toList()),
                    // floatingActionButton: FloatingActionButton(
                    //     backgroundColor: defaultAppBlueColor,
                    //     mini: true,
                    //     child: Icon(Icons.power_settings_new),
                    //     onPressed: () async {
                    //       await StorageUtil.removeString('userInfo');
                    //       await userTokendata.removeUserToken('token');
                    //     }),
                  )),
            );
          }),
    );
  }
}
