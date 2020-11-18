import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_x_genius/api/userTokenProvider.dart';
import 'package:simple_x_genius/constant/colors.dart';
import 'package:simple_x_genius/constant/registerNotification.dart';
import 'package:simple_x_genius/utility/tokenStoreUtil.dart';

import 'HomeParentPage.dart';
import 'homeTeacherPage.dart';

class HomeMainPage extends StatefulWidget {
  @override
  _HomeMainPageState createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  @override
  void initState() {
    if (StorageUtil.getListString('userInfo').isNotEmpty) {
      updateDeviceToken(
        context: context,
        currentUserType: StorageUtil.getListString(
            'userInfo')[1], //usertype teacher or parent
        phoneNumber: StorageUtil.getListString('userInfo')[2], //user phone
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userTokendata = Provider.of<UserTokenProvider>(context, listen: false);
    return StorageUtil.getListString('userInfo').isNotEmpty
        ? StorageUtil.getListString('userInfo')[1] == "Parent"
            ? HomeParentPage(
                parentInfo: StorageUtil.getListString('userInfo'),
              )
            : StorageUtil.getListString('userInfo')[1] == "Teacher"
                ? HomeTeacherPage(
                    teacherInfo: StorageUtil.getListString('userInfo'),
                  )
                : Scaffold(
                    body: Center(
                      child: Text("User info not avialable "),
                    ),
                    floatingActionButton: FloatingActionButton(
                        backgroundColor: defaultAppBlueColor,
                        mini: true,
                        child: Icon(Icons.power_settings_new),
                        onPressed: () async {
                          await StorageUtil.removeString('userInfo');
                          await userTokendata.removeUserToken('token');
                        }),
                  )
        : Scaffold(
            body: Center(
              child: Text("User info not avialable "),
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: defaultAppBlueColor,
                mini: true,
                child: Icon(Icons.power_settings_new),
                onPressed: () async {
                  await StorageUtil.removeString('userInfo');
                  await userTokendata.removeUserToken('token');
                }),
          );
  }
}
