import 'package:flutter/cupertino.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/model/attendanceStudentModel.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';

class SetattendencePovider extends ChangeNotifier {
  final NetWorkAPiRepository netWorkAPiRepository;
  NetWorkAPiRepository _netWorkAPiRepository = NetWorkAPiRepository();
  List<StudentInfoModel> studentsList = [];
  List<dynamic> checkBoxSelection1 = [];
   List<dynamic> checkBoxSelection2 = [];
  List<AttendanceStudentModel> attendaneceStudentAllData = [];
  bool _loaderState = false;

  bool get loaderState => _loaderState;

  set loaderState(bool loaderState) {
    _loaderState = loaderState;
    notifyListeners();
  }

  void checkBoxSingleSelection1(v, index) {
    checkBoxSelection1[index] = v;
    notifyListeners();
  }
   void checkBoxSingleSelection2(v, index) {
    checkBoxSelection1[index] = v;
    notifyListeners();
  }
  bool _allFullDayaSelction = false;
  bool _allHalfDayaSelction = false;
  bool _allSchoolHolidaySelection = false;

  bool get allSchoolHolidaySelection => _allSchoolHolidaySelection;

  set allSchoolHolidaySelection(bool allSchoolHolidaySelection) {
    _allSchoolHolidaySelection = allSchoolHolidaySelection;
    notifyListeners();
  }

  bool get allHalfDayaSelction => _allHalfDayaSelction;

  set allHalfDayaSelction(bool allHalfDayaSelction) {
    _allHalfDayaSelction = allHalfDayaSelction;
    notifyListeners();
  }

  bool get allFullDayaSelction => _allFullDayaSelction;

  set allFullDayaSelction(bool allFullDayaSelction) {
    _allFullDayaSelction = allFullDayaSelction;
    notifyListeners();
  }

  SetattendencePovider(this.netWorkAPiRepository);

  getStudentListOfASection(String classId, String sectionId) async {
    var studentListdata = await _netWorkAPiRepository
        .getStudentListClassWiseDataModel(classId, sectionId);
    studentsList = studentListdata;

    notifyListeners();
  }

  Future<bool> setAttendanceToAllProvider(
      {String classId,
      String sectionId,
      String attendance,
      String date}) async {
    loaderState = true;
    var result = await _netWorkAPiRepository.setAttendanceToallStudentDataModel(
        attendance: attendance,
        classId: classId,
        date: date,
        sectionId: sectionId);
    print(result);
    loaderState = false;

    return result;
  }

  Future<bool> setAttendanceToSingleStudentProvider(
      {String classId,
      String sectionId,
      String attendance,
      String studentId,
      String date}) async {
    loaderState = true;
    var result =
        await _netWorkAPiRepository.setAttendanceIndividualStudentDataModel(
            attendance: attendance,
            classId: classId,
            date: date,
            studentId: studentId,
            sectionId: sectionId);
    loaderState = false;
    return result;
  }

  getAttendanceOfAllStudent(
      {String classId, String secttionID, String month}) async {
    
        
    _loaderState = true;
    var response = await _netWorkAPiRepository.getAllStudentAttendanceDataModel(
        classId: classId, month: month, secttionID: secttionID);

    attendaneceStudentAllData = response;
    _loaderState = false;
    notifyListeners();
  }
 getAttendanceOfAllStudent2(
      {String classId, String secttionID, String month}) async {
        
    loaderState = true;
    var response = await _netWorkAPiRepository.getAllStudentAttendanceDataModel(
        classId: classId, month: month, secttionID: secttionID);

    attendaneceStudentAllData = response;
    loaderState = false;

  }
  clearAllSelcetion() {
    allSchoolHolidaySelection = false;
    allHalfDayaSelction = false;
    allFullDayaSelction = false;
    checkBoxSelection1 = [];
    checkBoxSelection2 = [];
  }
}
