import 'package:flutter/material.dart';
import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/attendanceSubmit/getClassAndSectionPage.dart';
import 'package:simple_x_genius/model/attenDatePassDataModel.dart';

import 'UI/pages/allCategoriesofTeacher/attendanceSubmit/setAttendancePage.dart';
import 'UI/pages/allCategoriesofTeacher/dairyNotesforTeacher/composeDairyNotes.dart';
import 'UI/pages/allCategoriesofTeacher/homeWorkForTeacher/composeHomeworkByTeacher.dart';
import 'UI/pages/allcategorisofStudent/attendancePage.dart';
import 'UI/pages/allcategorisofStudent/newsLetterPage.dart';
import 'UI/pages/allcategorisofStudent/parentDetailsPage.dart';
import 'UI/pages/allcategorisofStudent/studentDetails.dart';
import 'UI/pages/landingPage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    //hjgfjhgkuh

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LandingPage());

      // case '/categoryListPage':
      //   return MaterialPageRoute(builder: (_) => CategoryListPage());
      case '/studentDetailsPage':
        return MaterialPageRoute(builder: (_) => StudentDetails());

      case '/parentDetailsPage':
        return MaterialPageRoute(builder: (_) => ParentDetailsPage());
      case '/attendancePage':
        return MaterialPageRoute(builder: (_) => AttendancePage());
      case '/newsLetterPage':
        return MaterialPageRoute(builder: (_) => NewsLetterPage());

      case '/getClassSectionPage':
        return MaterialPageRoute(builder: (_) => GetClassAndSectionPage());

      case '/composeDairyNotes':
        return MaterialPageRoute(
            builder: (_) => ComposeDairyNotes(
                  teacherId: args,
                ));

      case '/composeMessageByTeacher':
        return MaterialPageRoute(
            builder: (_) => ComposeHomeWorkByTeacher(
                  teacherId: args,
                ));
      case '/setAttandencePage':
        AttendencePassAbleDataModel passAbleDataModel = args;
        return MaterialPageRoute(
            builder: (_) =>
                SetAttandencePage(passAbleDataModel: passAbleDataModel));

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
