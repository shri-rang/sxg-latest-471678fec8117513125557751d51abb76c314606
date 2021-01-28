class AssignmentList {
  String assignmentId;
  String studentId;
  String name;
  String docFile;
  String roll;
  String admNo;
  AssignmentList({
    this.assignmentId,
    this.name,
    this.roll,
    this.studentId,
    this.admNo,
    this.docFile,
  });

  AssignmentList.fromJson(Map<String, dynamic> json) {
    assignmentId = json['assignmentID'] ?? "";
    studentId = json['studentID'] ?? "";
    name = json['name'] ?? "";
    roll = json['roll'] ?? "";
    admNo = json['adm_no'] ?? "";
    // assignmentId = json['assignmentID'] ?? "";
    // title = json['title'] ?? "";
    docFile = json['doc_file'] ?? "";
  }
}

class StudentAssignmentList {
  String docFile;
  String studentID;
  String assignmentID;
  // String name;

  StudentAssignmentList({
    this.docFile,
    this.studentID,
    this.assignmentID,
  });

  StudentAssignmentList.fromJson(Map<String, dynamic> json) {
    docFile = json['doc_file'] ?? "";
    studentID = json['studentID'] ?? "";
    assignmentID = json['assignmentID'] ?? "";
  }
}
