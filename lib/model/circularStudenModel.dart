class CircularStudentModel {
  String messageId;
  String type;
  String title;
  String subject;
  String message;
  String attachFileName;
  String readStatus;
  String notifyTime;
  String notifyLoop;
  String notifyRepeat;
  String remindTime;
  String remindDate;
  String replyStatus;
  String favStatusSent;
  String from;
  String to;

  CircularStudentModel({
    this.message,
    this.messageId,
    this.attachFileName,
    this.favStatusSent,
    this.notifyLoop,
    this.notifyRepeat,
    this.notifyTime,
    this.readStatus,
    this.remindDate,
    this.remindTime,
    this.replyStatus,
    this.subject,
    this.type,
    this.title,
    this.from,
    this.to,
  });

  CircularStudentModel.fromJson(Map<String, dynamic> json) {
    messageId = json['messageID'] ?? "";
    message = json['message'] ?? "";
    type = json['type'] ?? "";
    subject = json['subject'] ?? "";
    attachFileName = json['attach_file_name'] ?? "";
    readStatus = json['read_status'] ?? "";
    notifyTime = json['notif_time'] ?? "";
    notifyLoop = json['notif_loop'] ?? "";
    notifyRepeat = json['notif_repeat'] ?? "";
    remindTime = json['remind_time'] ?? "";
    remindDate = json['remind_date'] ?? "";
    title = json['title'] ?? "";
    replyStatus = json['reply_status'] ?? "";
    favStatusSent = json['fav_status_sent'] ?? "";
    from = json["from"] ?? "";
    to = json["to"] ?? "";
  }
}
