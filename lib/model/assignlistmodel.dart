// To parse this JSON data, do
//
//     final listModel = listModelFromJson(jsonString);

import 'dart:convert';

ListModel listModelFromJson(String str) => ListModel.fromJson(json.decode(str));

String listModelToJson(ListModel data) => json.encode(data.toJson());

class ListModel {
  ListModel({
    this.sxg,
  });

  Sxg sxg;

  factory ListModel.fromJson(Map<String, dynamic> json) => ListModel(
        sxg: Sxg.fromJson(json["SXG"]),
      );

  Map<String, dynamic> toJson() => {
        "SXG": sxg.toJson(),
      };
}

class Sxg {
  Sxg({
    this.status,
    this.assignment,
  });

  Status status;
  List<Assignment> assignment;

  factory Sxg.fromJson(Map<String, dynamic> json) => Sxg(
        status: Status.fromJson(json["STATUS"]),
        assignment: List<Assignment>.from(
            json["assignment"].map((x) => Assignment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "STATUS": status.toJson(),
        "assignment": List<dynamic>.from(assignment.map((x) => x.toJson())),
      };
}

class Assignment {
  Assignment({
    this.studentId,
    this.assignmentId,
    this.docFile,
  });

  String studentId;
  String assignmentId;
  String docFile;

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        studentId: json["studentID"],
        assignmentId: json["assignmentID"],
        docFile: json["doc_file"],
      );

  Map<String, dynamic> toJson() => {
        "studentID": studentId,
        "assignmentID": assignmentId,
        "doc_file": docFile,
      };
}

class Status {
  Status({
    this.status,
    this.message,
    this.serverTimeStamp,
  });

  String status;
  String message;
  DateTime serverTimeStamp;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        status: json["STATUS"],
        message: json["MESSAGE"],
        serverTimeStamp: DateTime.parse(json["server_time_stamp"]),
      );

  Map<String, dynamic> toJson() => {
        "STATUS": status,
        "MESSAGE": message,
        "server_time_stamp": serverTimeStamp.toIso8601String(),
      };
}
