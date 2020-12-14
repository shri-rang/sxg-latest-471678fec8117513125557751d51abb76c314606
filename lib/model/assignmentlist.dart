class AssignmentList {
  String assignmentId;
  String docFile;

  AssignmentList({
    this.assignmentId,
    this.docFile,
  });

  AssignmentList.fromJson(Map<String, dynamic> json) {
    assignmentId = json['assignmentID'] ?? "";
    // title = json['title'] ?? "";
    docFile = json['doc_file'] ?? "";
  }
}
