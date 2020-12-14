import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/constant/colors.dart';
import 'package:simple_x_genius/route.dart';
import 'package:simple_x_genius/utility/tokenStoreUtil.dart';
import 'UI/pages/allCategoriesofTeacher/attendanceSubmit/getClassSectionProvider.dart';
import 'UI/pages/allCategoriesofTeacher/attendanceSubmit/setAttendanceProvider.dart';
import 'UI/pages/inbox/inboxProvider.dart';
import 'UI/pages/studentCircular/studentCircularDetailProvider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'api/userTokenProvider.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:simple_x_genius/UI/pages/allcategorisofStudent/assignment/uploadassignment.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  await FlutterDownloader.initialize(debug: true);
  await StorageUtil.getInstance();
  NetWorkAPiRepository netWorkAPiRepository = NetWorkAPiRepository();
  WidgetsFlutterBinding.ensureInitialized();
  InAppUpdate.checkForUpdate().then((value) => print(value));
  InAppUpdate.performImmediateUpdate();
  runApp(MultiProvider(
    child: MyApp(),
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserTokenProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => StudentCircularDetailsProvider(),
      ),
      // ChangeNotifierProvider(
      //   create: (_) => StudentUploadProvider(),
      // ),
      ChangeNotifierProvider(
        create: (_) => InBoxProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => GetClassSectionProvider(netWorkAPiRepository),
      ),
      ChangeNotifierProvider(
        create: (_) => SetattendencePovider(netWorkAPiRepository),
      )
    ],
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  var tokenRepo = Provider.of<UserTokenProvider>(context);

    return MaterialApp(
        title: 'Edwards English School',
        theme: ThemeData(
          primaryColor: defaultAppBlueColor,
        ),
        //  initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute
        // home: tokenRepo.getUserToken().isEmpty
        //   ? LoginPage():HomeParentMainPage(),
        );
  }
}
