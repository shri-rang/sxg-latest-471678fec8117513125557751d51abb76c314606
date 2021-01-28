class SendMessage {
  String messageID;
  String type;
  String title;
  String subject;
  String message;
  String from;
  String to;
  String attachFileName;
  String readStatus;
  String notifyTime;
  String notifyLoop;
  String notifyRepeat;
  String remindTime;
  String remindDate;
  String replyStatus;
  String favStatusSent;

  SendMessage(
      {this.messageID,
      this.type,
      this.title,
      this.subject,
      this.message,
      this.from,
      this.to,
      this.attachFileName,
      this.readStatus,
      this.notifyTime,
      this.notifyLoop,
      this.notifyRepeat,
      this.remindTime,
      this.remindDate,
      this.replyStatus,
      this.favStatusSent});
  SendMessage.fromMap(Map<String, dynamic> map) {
    messageID = map['messageID'] ?? "";
    type = map['type'] ?? "";
    title = map['title'] ?? "";
    subject = map['subject'] ?? "";
    message = map['message'] ?? "";
    from = map['from'] ?? "";
    to = map['to'] ?? "";
    attachFileName = map['attach_file_name'] ?? "";
    readStatus = map['read_status'] ?? "";
    notifyTime = map['notif_time'] ?? "";
    notifyLoop = map['notif_loop'] ?? "";
    notifyRepeat = map['notif_repeat'] ?? "";
    remindTime = map['remind_time'] ?? "";
    remindDate = map['remind_date'] ?? "";
    replyStatus = map['reply_status'] ?? "";
    favStatusSent = map['fav_status_sent'] ?? "";
  }
}

class ReplyMessage {
  String replyId;
  String messageID;
  String title;
  String replyMessage;
  String creationTime;
  String status;
  String parentId;
  String fileURL;
  String name;

  ReplyMessage({
    this.replyId,
    this.messageID,
    this.title,
    this.creationTime,
    this.parentId,
    this.replyMessage,
    this.status,
    this.fileURL,
    this.name,
  });
  ReplyMessage.fromJson(Map<String, dynamic> json) {
    replyId = json['replyID'] ?? "";
    messageID = json['messageID'] ?? "";
    title = json['title'] ?? "";
    replyMessage = json['reply_msg'] ?? "";
    status = json['status'] ?? "";
    creationTime = json['create_time'] ?? "";
    fileURL = json['photo'] ?? "";
    parentId = json['parentID'] ?? "";
    name = json['name'] ?? "";
  }
}
