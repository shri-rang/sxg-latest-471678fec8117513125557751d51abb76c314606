// To parse this JSON data, do
//
//     final feeModel = feeModelFromJson(jsonString);

import 'dart:convert';

FeeModel feeModelFromJson(String str) => FeeModel.fromJson(json.decode(str));

String feeModelToJson(FeeModel data) => json.encode(data.toJson());

class FeeModel {
    FeeModel({
        this.sxg,
    });

    Sxg sxg;

    factory FeeModel.fromJson(Map<String, dynamic> json) => FeeModel(
        sxg: Sxg.fromJson(json["SXG"]),
    );

    Map<String, dynamic> toJson() => {
        "SXG": sxg.toJson(),
    };
}

class Sxg {
    Sxg({
        this.status,
        this.studentdata,
    });

    Status status;
    List<Studentdatum> studentdata;

    factory Sxg.fromJson(Map<String, dynamic> json) => Sxg(
        status: Status.fromJson(json["STATUS"]),
        studentdata: List<Studentdatum>.from(json["studentdata"].map((x) => Studentdatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "STATUS": status.toJson(),
        "studentdata": List<dynamic>.from(studentdata.map((x) => x.toJson())),
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

class Studentdatum {
    Studentdatum({
        this.month,
        this.classesId,
        this.sectionId,
        this.studentId,
        this.student,
        this.amount,
        this.dueAmount,
        this.paidAmount,
        this.satus,
        this.fyear,
    });

    String month;
    String classesId;
    String sectionId;
    String studentId;
    String student;
    String amount;
    String dueAmount;
    String paidAmount;
    String satus;
    Fyear fyear;

    factory Studentdatum.fromJson(Map<String, dynamic> json) => Studentdatum(
        month: json["month"],
        classesId: json["classesID"],
        sectionId: json["sectionID"],
        studentId: json["studentID"],
        student: json["student"],
        amount: json["amount"],
        dueAmount: json["due_amount"],
        paidAmount: json["paid_amount"],
        satus: json["satus"],
        fyear: fyearValues.map[json["fyear"]],
    );

    Map<String, dynamic> toJson() => {
        "month": month,
        "classesID": classesId,
        "sectionID": sectionId,
        "studentID": studentId,
        "student": student,
        "amount": amount,
        "due_amount": dueAmount,
        "paid_amount": paidAmount,
        "satus": satus,
        "fyear": fyearValues.reverse[fyear],
    };
}

enum Fyear { THE_20202021 }

final fyearValues = EnumValues({
    "2020-2021": Fyear.THE_20202021
});

// enum Satus { DUE }

// final satusValues = EnumValues({
//     "DUE": Satus.DUE
// });

// enum Student { ANJALI_KUMARI }

// final studentValues = EnumValues({
//     "ANJALI KUMARI": Student.ANJALI_KUMARI
// });

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
