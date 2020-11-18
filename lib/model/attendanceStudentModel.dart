class AttendanceStudentModel {
  String studentID;
  String classesID;
  String name;
  String sectionID;
  String attendance;
  String roll;
  
  AttendanceStudentModel.fromJson(Map<String, dynamic> json) {
    studentID = json['studentID'] ?? "";
    classesID = json['classesID'] ?? "";
    name = json['name'] ?? "";
    sectionID = json['sectionID'] ?? "";
    attendance = json['attendance'] ?? "";
    roll=json['roll']??"";
  }
}
