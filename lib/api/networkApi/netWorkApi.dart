import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/chooseInboxSent.dart';
import 'package:http/http.dart' as http;
import 'package:simple_x_genius/model/feesInvoiceInfoModel.dart';

class NetworkApiClient {
  static String baseLoginUrl =
      "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/apihost";
  Dio _dio;
  NetworkApiClient() {
    BaseOptions options =
        BaseOptions(receiveTimeout: 10000, connectTimeout: 10000);
    _dio = Dio(options);
    // _dio.interceptors.add(ApiInterceptor());
  }

  Future loginUser(String userName, String userPass) async {
    String login = "http://theduncanacademy.com/apihost";
    final url = "$login/parentlogin";
    try {
      // var response=  await   http.post(url);

      var response = await _dio.post(url, queryParameters: {
        'username': userName,
        'password': userPass,
      });
      // var data = json.decode(response.data);

      // print(data);
      print(response.data);
      return response.data;
    } on DioError {
      // throw e.error;
      return false;
    }
  }

  getStudentAttendance(String studenId, String monthYear) async {
    final url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_attendance.php?studentId=$studenId&month=$monthYear";
    try {
      // var response=  await   http.post(url);

      var response = await _dio.post(url);

      //  print(data);

      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  Future getStuentDataFromserver(String parentNumber) async {
    final url =
        'https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_childbyparentnumber.php?parent=$parentNumber';

    try {
      var response = await _dio.post(url);

      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  Future getCircularofAStudent(String studentId) async {
    final url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_circular.php?studentID=$studentId";
    try {
      var response = await _dio.post(url);

      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  Future getHWCircularDNoteFromServer(String id, bool isTeacher,
      {@required UIType uitype}) async {
    final url = uitype == UIType.HomeWOrk
        ? isTeacher
            ? "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_tlisthomework.php?uid=$id" //teacher homework
            : "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_homework.php?studentID=$id" //student homework
        : uitype == UIType.Circualr
            ? isTeacher
                ? "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_tcircular.php?uid=$id" //teacher circualr
                : "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_circular.php?studentID=$id" //student circular
            : uitype == UIType.DairyNotes
                ? isTeacher
                    ? "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/sxgwebservice/Get_tlistdiarynotes.php?uid=$id" //teacher dairy note
                    : "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_diarynotes.php?studentID=$id" //student dairy note
                : "";

    try {
      var response = await _dio.post(url);

      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  Future getParentInfoFromServer(String parentId) async {
    final url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_parentslist.php?ParentID=$parentId";
    try {
      var response = await _dio.post(url);

      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  Future getTeacherInfoFromServer(String teacherNumber) async {
    final url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_teacherlist.php?teachernumber=$teacherNumber";

    try {
      var response = await _dio.get(
        url,
      );

      return response.data;
    } on DioError {
      return null;
    }
  }

  Future getClassFromServer() async {
    final url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_classlist.php";

    try {
      var response = await _dio.get(
        url,
      );

      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  Future getSectionFromServer(String classId) async {
    final url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_sectionlist.php?classid=$classId";

    try {
      var response = await _dio.get(
        url,
      );

      //   print(response);

      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  Future getStudentListSectionWiseFromServer(
      String classId, String sectionId) async {
    final url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_studentclasswise.php?classid=$classId&ssectionid=$sectionId";

    try {
      var response = await _dio.get(
        url,
      );

      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  Future setAttendanceToAllStudent(
      {String classId,
      String sectionId,
      String attendance,
      String date}) async {
    final url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Post_updateAttendance.php";

    try {
      var response = await _dio.post(url, data: {
        "SXG": {
          "classid": classId,
          "sectionid": sectionId,
          "attendance": attendance,
          "date": date,
          "studentid": ""
        }
      });

      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  Future setAttendanceToIndividualStudent(
      {String classId,
      String sectionId,
      String studentId,
      String attendance,
      String date}) async {
    final url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Post_updateAttendance.php";

    try {
      var response = await _dio.post(url, data: {
        "SXG": {
          "classid": classId,
          "sectionid": sectionId,
          "attendance": attendance,
          "date": date,
          "studentid": studentId
        }
      });

      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  setComposeMessageDataToServer(
      {File attachement,
      String classId,
      String sectionId,
      String subject,
      String fileName,
      String teacherId,
      String fileExtension,
      String message}) async {
    final String url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Post_sendhomework.php";

    FormData formData = FormData();

    if (attachement != null) {
      formData.files.add(MapEntry(
          "uploaded_file",
          await MultipartFile.fromFile(attachement.path,
              filename: fileName,
              contentType: MediaType(
                  fileExtension == "pdf" ? 'application' : 'image',
                  fileExtension))));
    }

    formData.fields.add(
      MapEntry("classid", classId),
    );
    formData.fields.add(
      MapEntry("sectionid", sectionId),
    );
    formData.fields.add(
      MapEntry("subject", subject),
    );

    formData.fields.add(
      MapEntry("message", message),
    );
    formData.fields.add(
      MapEntry("teacherid", teacherId),
    );
    if (attachement != null) {
      formData.fields.add(
        MapEntry("attachment", fileExtension == "pdf" ? "0" : "1"),
      );
    }
    try {
      var response = await _dio.post(url,
          data: formData,
          options: Options(headers: {"Content-Type": "multipart/form-data"}));
      //  print(response.data);

      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  setComposeDiaryNotes(
      {File attachement,
      String classId,
      String studentId,
      String sectionId,
      String subject,
      String fileName,
      String teacherId,
      String fileExtension,
      String message}) async {
    final String url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Post_senddiarynotes.php";

    FormData formData = FormData();

    // print(classId);
    // print(studentId);
    // print(sectionId);
    // print(subject);

    // print(fileName);
    // print(teacherId);
    // print(message);
    if (attachement != null) {
      formData.files.add(MapEntry(
          "uploaded_file",
          await MultipartFile.fromFile(attachement.path,
              filename: fileName,
              contentType: MediaType(
                  fileExtension == "pdf" ? 'application' : 'image',
                  fileExtension))));
    }
    formData.fields.add(
      MapEntry("classid", classId),
    );
    formData.fields.add(
      MapEntry("sectionid", sectionId),
    );
    formData.fields.add(
      MapEntry("subject", subject),
    );

    formData.fields.add(
      MapEntry("message", message),
    );
    formData.fields.add(
      MapEntry("teacherid", teacherId),
    );
    formData.fields.add(
      MapEntry("studentid", studentId),
    );
    if (attachement != null) {
      formData.fields.add(
        MapEntry("attachment", fileExtension == "pdf" ? "0" : "1"),
      );
    }
    //This comment

    try {
      var response = await _dio.post(url,
          data: formData,
          options: Options(headers: {"Content-Type": "multipart/form-data"}));
      // print(response.data);

      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  Future updateReadStatusToServer(String messageId) async {
    final String url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Post_update.php";
    try {
      var response = await _dio.post(
        url,
        data: {
          "SXG": {'messageID': messageId}
        },
      );
      //  print(response.data);

      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  getallStudentOfaSectionFromServer(
      {String classid, String sectionId, String name}) async {
    final String url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_studentclasswisename.php";
    try {
      // var response=  await   http.post(url);

      var response = await _dio.get(url, queryParameters: {
        'classid': classid,
        'ssectionid': sectionId,
      });
      // var data = json.decode(response.data);

      // print(data);

      // print(response);
      // print(classid);
      // print(sectionId);

      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  Future getReplyMesageFromServer(String messageId, UIType uiType) async {
    final url = uiType == UIType.DairyNotes
        ? "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_tlistdiarynotesdetail.php"
        : uiType == UIType.HomeWOrk
            ? "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_tlisthomeworkdetail.php"
            : "";

    try {
      var response =
          await _dio.get(url, queryParameters: {'messageID': messageId});
      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  Future getCircularDetailsFromServer(String messageId, UIType uiType) async {
    final url = uiType == UIType.DairyNotes
        ? "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_tlistdiarynotesdetail.php"
        : uiType == UIType.HomeWOrk
            ? "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_tlisthomeworkdetail.php"
            : "";

    try {
      var response =
          await _dio.get(url, queryParameters: {'messageID': messageId});
      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

//This handles sending reply
  Future setReplyMessage(
      {String messageId,
      String title,
      String replyMessage,
      String status,
      String parentId,
      File uploadedFile}) async {
    final String url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Post_reply.php";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields["messageID"] = messageId;
    request.fields["title"] = title;
    request.fields["reply_msg"] = replyMessage;
    request.fields["status"] = status;
    request.fields["parentID"] = parentId;
    if (uploadedFile != null)
      request.files.add(await http.MultipartFile.fromPath(
          "uploaded_file", uploadedFile.path));
    try {
      var response = await request.send();
      print(response.reasonPhrase);

      return response.reasonPhrase;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  Future getInboxMessages(String uid, bool isHomeWork) async {
    final String url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_tlistinbox.php";

    try {
      var response = await _dio.get(url, queryParameters: {
        'uid': uid,
        'type': isHomeWork ? "homework" : "dairynotes"
      });
      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  Future getClassNameFromServer(String classId) async {
    final String url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_classlist.php";
    try {
      var response =
          await _dio.get(url, queryParameters: {'classesID': classId});
      return response.data;
    } on DioError {
      return "";
    }
  }

  updateToken({String token, String number, String type}) async {
    final String url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Post_tokenupdate.php";
    try {
      var response = await _dio.post(
        url,
        data: {
          "SXG": {"id": token, "number": number, "type": type}
        },
      );
      print(response.data);
      //  just i fixed try again api not available for this device matlab ?

      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  getAllStudentAttendanceFromServer(
      {String classId, String secttionID, String month}) async {
    final String url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_studentattendance.php";
    try {
      var response = await _dio.get(url, queryParameters: {
        'classid': classId,
        'ssect': secttionID,
        'month': month
      });
      return response.data;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  Future changePassWordApi(
      {String oldPassword, String newPassword, String phoneNumber}) async {
    final String url = "http://theduncanacademy.com/apihostt/change_password";
    // "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/apihost/change_password";
    try {
      var response = await _dio.post(url, queryParameters: {
        'username': phoneNumber,
        'password': oldPassword,
        'newpassword': newPassword,
        'confirm': newPassword
      });
      //   print(response);
      return response.data;
    } on DioError {
      return false;
    }
  }

  Future forgetPassWordApi(
      {String otp, String newPassword, String phoneNumber}) async {
    final String url = "http://theduncanacademy.com/apihost/forget_password";
    // "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/apihost/forget_password";
    try {
      var response = await _dio.post(url, queryParameters: {
        'username': phoneNumber,
        'otp': otp,
        'newpassword': newPassword,
        'confirm': newPassword
      });
      print(response);
      return response.data;
    } on DioError {
      return false;
    }
  }

  Future forgetPassPhoneInputApi(String phoneNumber) async {
    final String url = "http://theduncanacademy.com/apihost/forget_password";
    // "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/apihost/forget_password";

    try {
      var response = await _dio.post(url, queryParameters: {
        'username': phoneNumber,
      });
      print(response);
      return response.data;
    } on DioError {
      return false;
    }
  }

  getStudentSectionApi(String sectionID) async {
    final url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_sectionlist.php?sectionID=$sectionID";

    try {
      var response = await _dio.get(
        url,
      );

      return response.data;
    } on DioError {
      return "";
    }
  }

  Future<List<FeeModel>> getFeesInvoice() async {
    final url =
        "https://zvb.fbs.mybluehostin.me/duncan/duncanwebservice/Get_getfees.php?studentId=1";

    try {
      var res = await _dio.get(
        url,
      );
      return res.data;
    } on DioError {
      return null;
    }
  }
}
