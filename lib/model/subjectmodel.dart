class SubjectModel {
  String subject;
  String classesId;
  String subjectId;
  // String teacherId;
  // String notes;

  SubjectModel.fromJson(Map<String, dynamic> map) {
    subject = map['subject'] ?? "";
    classesId = map['classesID'] ?? "";
    subjectId = map['subjectID'] ?? "";
    // teacherId=map['teacherID']??"";
    // notes=map['note']??"";
  }
}
