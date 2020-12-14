class ViewAssignmentModel {
  String assignmentId;
  String title;
  String message;
  String classId;
  String classes;
  String section;
  String docFile;

  ViewAssignmentModel(
      {this.assignmentId,
      this.title,
      this.message,
      this.classId,
      this.classes,
      this.section,
      this.docFile});

  ViewAssignmentModel.fromJson(Map<String, dynamic> json) {
    assignmentId = json['assignmentID'] ?? "";
    // title = json['title'] ?? "";
    title = json['title'] ?? "";
    message = json['message'] ?? "";
    classId = json['classId'] ?? "";
    classes = json['classes'] ?? "";
    section = json['section'] ?? "";
    docFile = json['doc_file'] ?? "";
  }
}
