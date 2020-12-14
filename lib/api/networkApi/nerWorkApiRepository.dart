import 'dart:io';

import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/chooseInboxSent.dart';
import 'package:simple_x_genius/api/networkApi/netWorkApi.dart';
import 'package:simple_x_genius/model/attendanceStudentModel.dart';
import 'package:simple_x_genius/model/circularStudenModel.dart';
import 'package:simple_x_genius/model/classModel.dart';
import 'package:simple_x_genius/model/parentsInfoModel.dart';
import 'package:simple_x_genius/model/sectionModel.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';
import 'package:simple_x_genius/model/teacherInfoModel.dart';
import 'package:simple_x_genius/model/viewassignmentModel.dart';
import 'package:simple_x_genius/model/youtubeVideo.dart';
import 'package:simple_x_genius/utility/tokenStoreUtil.dart';
import 'package:simple_x_genius/model/assignmentlist.dart';
import 'package:simple_x_genius/model/liveclasses.dart';
// import 'package:simple_x_genius/model/feesInvoiceInfoModel.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class NetWorkAPiRepository {
  NetworkApiClient _networkApiClient;

  NetWorkAPiRepository() {
    _networkApiClient = NetworkApiClient();
  }

  Future loginUserUsingRepo(String email, String pass) async {
    var response = await _networkApiClient.loginUser(email, pass);

    if (response is bool) {
      return false;
    } else {
      if (response[0]['result'] == "success") {
        await StorageUtil.putListString('userInfo', [
          response[0]['loginuserID'],
          response[0]['usertype'],
          response[0]['username']
        ]);
        return response[0]['token'];
      } else if (response[0]['result'] == "failure") {
        return false;
      } else if (response[0]['result']['result'] == "success") {
        await StorageUtil.putListString('userInfo', [
          response[0]['result']['loginuserID'],
          response[0]['result']['usertype'],
          response[0]['result']['username']
        ]);

        return response[0]['result']['token']; //where using token return ??????
      } else if (response[0]['result'] == "failure") {
        return false;
      } else if (response[0]['result']['result'] == "success") {
        await StorageUtil.putListString('userInfo', [
          response[0]['result']['loginuserID'],
          response[0]['result']['usertype'],
          response[0]['result']['username']
        ]);

        return response[0]['result']['token'];
      } else {
        return false;
      }
    }
  }

  Future<List<StudentInfoModel>> getStudentDataRepo(String parentNumber) async {
    var response =
        await _networkApiClient.getStuentDataFromserver(parentNumber);
    List<StudentInfoModel> infoModel = [];

    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["student data"] as List;

      data.forEach(
          (element) => {infoModel.add(StudentInfoModel.fromMap(element))});

      return infoModel;
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<List<CircularStudentModel>> getStudentCircularDataModel(
      String studentId) async {
    var response = await _networkApiClient.getCircularofAStudent(studentId);
    List<CircularStudentModel> infoModel = [];

    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["circular_data"] as List;

      data.forEach(
          (element) => {infoModel.add(CircularStudentModel.fromJson(element))});

      return infoModel;
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<List<CircularStudentModel>> getHWCricularDNoteListByDataModel(
      {String classesid,
      String sectionid,
      String id,
      bool isTeacher,
      @required UIType uitype}) async {
    List<CircularStudentModel> infoModel = [];

    var response = await _networkApiClient.getHWCircularDNoteFromServer(
        id: id,
        isTeacher: isTeacher,
        uitype: uitype,
        classesid: classesid,
        sectionid: sectionid);

    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"][uitype == UIType.HomeWOrk
          ? "homework_data"
          : uitype == UIType.DairyNotes
              ? isTeacher
                  ? "diarynotes_data"
                  : "homework_data"
              : uitype == UIType.Circualr
                  ? 'circular_data'
                  : ""] as List;

      data.forEach(
          (element) => {infoModel.add(CircularStudentModel.fromJson(element))});

      return infoModel;
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<ParensInfoModel> getParentInfoRepo(String parentId) async {
    try {
      var response = await _networkApiClient.getParentInfoFromServer(parentId);

      var data = ParensInfoModel.fromMap(response["SXG"]["parent data"][0]);

      return data;
    } catch (error) {
      throw Exception('Failed to load ');
    }
  }

  Future<TeacherInfoModel> getTeacherInfoDataModel(String teacherId) async {
    var response = await _networkApiClient.getTeacherInfoFromServer(teacherId);
    if (response == null)
      return null;
    else if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = TeacherInfoModel.fromJson(response["SXG"]['teachers data'][0]);
      return data;
    } else {
      return null;
    }
  }

  Future<File> createFileOfPdfUrl(String urlLink) async {
    final url = urlLink;
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  Future getStudentAttendanceModel(String studentId, String monthYear) async {
    var response =
        await _networkApiClient.getStudentAttendance(studentId, monthYear);

    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      return response['SXG']['attendance data'][0];
    } else {
      return null;
    }
  }

  Future<List<ClassModel>> getClassDataModel() async {
    List<ClassModel> classModels = [];
    var response = await _networkApiClient.getClassFromServer();

    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["classes data"] as List;

      data.forEach(
          (element) => {classModels.add(ClassModel.fromJson(element))});
      return classModels;
    } else {
      return [];
    }
  }

  Future<List<SectionModel>> getSectionDataModel(String classId) async {
    List<SectionModel> sectionModels = [];
    var response = await _networkApiClient.getSectionFromServer(classId);

    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["section data"] as List;

      data.forEach(
          (element) => {sectionModels.add(SectionModel.fromJson(element))});
      return sectionModels;
    } else {
      return [];
    }
  }

  Future<List<StudentInfoModel>> getStudentListClassWiseDataModel(
      String classId, String sectionId) async {
    List<StudentInfoModel> studentListModels = [];
    var response = await _networkApiClient.getStudentListSectionWiseFromServer(
        classId, sectionId);

    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["student_data"] as List;

      data.forEach((element) =>
          {studentListModels.add(StudentInfoModel.fromMap(element))});
      return studentListModels;
    } else {
      return [];
    }
  }

  Future<bool> setAttendanceToallStudentDataModel(
      {String classId,
      String sectionId,
      String attendance,
      String date}) async {
    var response = await _networkApiClient.setAttendanceToAllStudent(
        classId: classId,
        sectionId: sectionId,
        date: date,
        attendance: attendance);

    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setAttendanceIndividualStudentDataModel(
      {String classId,
      String sectionId,
      String studentId,
      String attendance,
      String date}) async {
    var response = await _networkApiClient.setAttendanceToIndividualStudent(
        classId: classId,
        sectionId: sectionId,
        date: date,
        studentId: studentId,
        attendance: attendance);
    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setComposeMessageDataModel(
      {File attachement,
      String classId,
      String sectionId,
      String subject,
      String fileName,
      String teacherId,
      @required bool isHomeWOrk,
      String fileExtension,
      String message}) async {
    var response = await _networkApiClient.setComposeMessageDataToServer(
        classId: classId,
        attachement: attachement,
        fileName: fileName,
        message: message,
        sectionId: sectionId,
        fileExtension: fileExtension,
        subject: subject,
        teacherId: teacherId);
    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> sendAssignmentData(
      {File attachement,
      String classId,
      String sectionId,
      String subject,
      String fileName,
      String teacherId,
      @required bool isHomeWOrk,
      String fileExtension,
      String message}) async {
    var response = await _networkApiClient.sendAssignmentDataToServer(
        classId: classId,
        attachement: attachement,
        fileName: fileName,
        message: message,
        sectionId: sectionId,
        fileExtension: fileExtension,
        subject: subject,
        teacherId: teacherId);
    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setComposeDairyDataModel(
      {File attachement,
      String classId,
      String sectionId,
      String subject,
      String fileName,
      String teacherId,
      String studentId,
      String fileExtension,
      String message}) async {
    var response = await _networkApiClient.setComposeDiaryNotes(
        classId: classId,
        attachement: attachement,
        fileName: fileName,
        message: message,
        sectionId: sectionId,
        fileExtension: fileExtension,
        studentId: studentId,
        subject: subject,
        teacherId: teacherId);
    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateReadStatusDataModel(String messageId) async {
    var response = await _networkApiClient.updateReadStatusToServer(messageId);
    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      return true;
    } else {
      return false;
    }
  }

  Future getallStudentOfaSectionDataModel(
      {String sectId, String classId, String name}) async {
    List<StudentInfoModel> studentListModels = [];
    var response = await _networkApiClient.getallStudentOfaSectionFromServer(
      sectionId: sectId,
      classid: classId,
    );

    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["student_data"] as List;
      data.forEach((element) =>
          {studentListModels.add(StudentInfoModel.fromMap(element))});
      return studentListModels;
    } else {
      return [];
    }
  }

  Future<String> getClassNameDataModel(String classId) async {
    var response = await _networkApiClient.getClassNameFromServer(classId);
    if (response is String) {
      return "";
    } else {
      if (response["SXG"]["STATUS"]["STATUS"] == "1") {
        return response["SXG"]['classes data'][0]['classes'];
      } else {
        return "";
      }
    }
  }

  Future getAllStudentAttendanceDataModel(
      {String classId, String secttionID, String month}) async {
    List<AttendanceStudentModel> allStudentsAttd = [];
    var response = await _networkApiClient.getAllStudentAttendanceFromServer(
        classId: classId, month: month, secttionID: secttionID);
    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["student data"] as List;
      data.forEach((element) =>
          {allStudentsAttd.add(AttendanceStudentModel.fromJson(element))});

      return allStudentsAttd;
    } else {
      return [];
    }
  }

  Future<bool> changePasswordRepo(
      {String oldPassword, String newPassword, String phoneNumber}) async {
    var response = await _networkApiClient.changePassWordApi(
        newPassword: newPassword,
        oldPassword: oldPassword,
        phoneNumber: phoneNumber);

    if (response is bool) {
      return false;
    } else if (response[0][0]['result'] == "success")
      return true;
    else if (response[0][0]['result'] == "failure")
      return false;
    else
      return false;
  }

  Future forgotPasswordRepo(
      {String otp, String newPassword, String phoneNumber}) async {
    var response = await _networkApiClient.forgetPassWordApi(
        newPassword: newPassword, otp: otp, phoneNumber: phoneNumber);

    if (response[0][0]['result'] == "success") {
      return true;
    } else {
      return response[0][0]['message'];
    }
  }

  Future<bool> forgotPassPhoneAuthRepo(String phoneNumber) async {
    var response = await _networkApiClient.forgetPassPhoneInputApi(phoneNumber);
    if (response != null) {
      if (response[0][0]['result'] == "failure")
        return false;
      else if (response[0][0]['result'] == "success")
        return true;
      else
        return false;
    } else {
      return false;
    }
  }

  Future<List<ViewAssignmentModel>> viewAssignmentTeacher(
      String teacherId) async {
    print(teacherId);
    List<ViewAssignmentModel> viewassignment = [];
    var response = await _networkApiClient.viewAssignment(teacherId);
    if (response != null) {
      if (response["SXG"]["STATUS"]["STATUS"] == "1") {
        var data = response["SXG"]["assignment"] as List;
        data.forEach((element) =>
            {viewassignment.add(ViewAssignmentModel.fromJson(element))});

        return viewassignment;
      } else {
        return [];
      }
    } else {
      return response;
    }
  }

  Future<List<ViewAssignmentModel>> viewStudentAssignments(
      String classesId, String sectionId) async {
    List<ViewAssignmentModel> viewtheassignment = [];
    var response =
        await _networkApiClient.viewStudentAssignment(classesId, sectionId);

    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["assignment"] as List;
      data.forEach((element) =>
          {viewtheassignment.add(ViewAssignmentModel.fromJson(element))});

      return viewtheassignment;
    } else {
      return [];
    }
  }

  Future<List<AssignmentList>> listingAssignment(String assignmentId) async {
    List<AssignmentList> assignmentList = [];
    var response = await _networkApiClient.assignmentListing(assignmentId);
    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["assignment"] as List;
      data.forEach(
          (element) => {assignmentList.add(AssignmentList.fromJson(element))});

      return assignmentList;
    } else {
      return [];
    }
  }

  Future<List<YoutubeVideo>> viewYoutubeVideo() async {
    List<YoutubeVideo> videoList = [];
    var response = await _networkApiClient.youTubeVideo();

    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["news data"] as List;
      data.forEach(
          (element) => {videoList.add(YoutubeVideo.fromJson(element))});

      return videoList;
    } else {
      return response;
    }
  }

  Future<List<UpcomingLiveModel>> studentUpcomingClasses(
      String classesId, String sectionId) async {
    List<UpcomingLiveModel> upcomingLive = [];
    print(classesId);
    print(classesId);
    var response =
        await _networkApiClient.upcomingClassesStudent(classesId, sectionId);
    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["studentdata"] as List;

      data.forEach(
          (element) => {upcomingLive.add(UpcomingLiveModel.fromJson(element))});

      return upcomingLive;
    } else {
      return response;
    }
  }

  Future<List<TodayLiveModel>> studentTodayClasses(
      String classesId, String sectionId) async {
    List<TodayLiveModel> upcomingLive = [];
    var response =
        await _networkApiClient.todayClassesStudent(classesId, sectionId);
    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["studentdata"] as List;
      data.forEach(
          (element) => {upcomingLive.add(TodayLiveModel.fromJson(element))});

      return upcomingLive;
    } else {
      return response;
    }
  }

  Future<List<CompletedLiveModel>> studentCompletedClasses(
      String classesId, String sectionId) async {
    List<CompletedLiveModel> completedLive = [];
    var response =
        await _networkApiClient.completedClassesStudent(classesId, sectionId);
    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["studentdata"] as List;
      data.forEach((element) =>
          {completedLive.add(CompletedLiveModel.fromJson(element))});

      return completedLive;
    } else {
      return response;
    }
  }

  Future<List<TodayLiveModelTeacher>> teacherTodayClasses(
    String teacherId,
  ) async {
    List<TodayLiveModelTeacher> upcomingLive = [];
    var response = await _networkApiClient.todayClassesTeacher(teacherId);
    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["studentdata"] as List;
      data.forEach((element) =>
          {upcomingLive.add(TodayLiveModelTeacher.fromJson(element))});

      return upcomingLive;
    } else {
      return response;
    }
  }

  Future<List<CompletedLiveModelTeacher>> teacherUpcomingClasses(
    String teacherId,
  ) async {
    List<CompletedLiveModelTeacher> upcomingLive = [];
    var response = await _networkApiClient.upcomingClassesTeacher(
      teacherId,
    );
    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["studentdata"] as List;
      data.forEach((element) =>
          {upcomingLive.add(CompletedLiveModelTeacher.fromJson(element))});

      return upcomingLive;
    } else {
      return response;
    }
  }

  Future<List<CompletedLiveModelTeacher>> teacherCompletedClasses(
    String teacherId,
  ) async {
    List<CompletedLiveModelTeacher> completedLive = [];
    var response = await _networkApiClient.completedClassesTeacher(
      teacherId,
    );
    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["studentdata"] as List;
      data.forEach((element) =>
          {completedLive.add(CompletedLiveModelTeacher.fromJson(element))});

      return completedLive;
    } else {
      return response;
    }
  }

  classActive(String teacherId, String meetingId) async {
    var response = await _networkApiClient.activeClass(teacherId, meetingId);
    print(teacherId);
    print(meetingId);
    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["update"] as List;

      return data;
    } else {
      return response;
    }
  }

  classesAdd(
      {String date,
      String classesId,
      String sectionId,
      String subject,
      String jointime,
      String teacherId,
      String meetingId,
      String endtime}) async {
    var response = await _networkApiClient.addClasses(
      date: date,
      classesId: classesId,
      sectionId: sectionId,
      subject: subject,
      jointime: jointime,
      teacherId: teacherId,
      meetingId: meetingId,
      endtime: endtime,
    );
    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["update"]["success"];
      print(data);
      print(response);
      return data;
    } else {
      return response;
    }
  }

  Future<String> getStudentSectionData(String section) async {
    var response = await _networkApiClient.getStudentSectionApi(section);
    if (response is String) {
      return "";
    } else {
      if (response["SXG"]["STATUS"]["STATUS"] == "1") {
        return response["SXG"]["section data"][0]["section"];
      } else {
        return "";
      }
    }
  }
}
