class InboxModel {
  String to;
  String from;
  String replyID;
  String title;
  String messageID;
  String replyMsg;
  String status;
  String createTime;
  String parentID;

  InboxModel(
      {this.to,
      this.from,
      this.replyID,
      this.title,
      this.messageID,
      this.parentID,
      this.status,
      this.replyMsg,
      this.createTime});

  InboxModel.fromJson(Map<String, dynamic> json) {
    to = json['to'] ?? "";
    from = json['from'] ?? "";
    replyMsg = json['reply_msg'] ?? "";
    replyID = json['replyID'] ?? "";
    title = json['title'] ?? "";
    messageID = json['messageID'] ?? "";
    status = json['status'] ?? "";
    createTime = json['create_time'] ?? "";
    parentID = json['parentID'] ?? "";
  }
}
