class UpcomingLiveModel {
  String subject;
  String msstatus;
  String joinurl;
  String scheduleDate;
  String scheduleTime;
  String endTime;
  String teacher;

  UpcomingLiveModel({
    this.subject,
    this.msstatus,
    this.joinurl,
    this.scheduleDate,
    this.scheduleTime,
    this.endTime,
    this.teacher,
  });

  UpcomingLiveModel.fromJson(Map<String, dynamic> json) {
    subject = json['subject'] ?? "";
    // title = json['title'] ?? "";
    msstatus = json['mstatus'] ?? "";
    joinurl = json['join_url'] ?? "";
    scheduleDate = json['schedule_date'] ?? "";
    scheduleTime = json['schedule_time'] ?? "";
    endTime = json['end_time'] ?? "";
    teacher = json['teacher'] ?? "";
  }
}

class CompletedLiveModel {
  String subject;
  String msstatus;
  String joinurl;
  String scheduleDate;
  String scheduleTime;
  String endTime;
  String teacher;

  CompletedLiveModel({
    this.subject,
    this.msstatus,
    this.joinurl,
    this.scheduleDate,
    this.scheduleTime,
    this.endTime,
    this.teacher,
  });

  CompletedLiveModel.fromJson(Map<String, dynamic> json) {
    subject = json['subject'] ?? "";
    // title = json['title'] ?? "";
    msstatus = json['mstatus'] ?? "";
    joinurl = json['join_url'] ?? "";
    scheduleDate = json['schedule_date'] ?? "";
    scheduleTime = json['schedule_time'] ?? "";
    endTime = json['end_time'] ?? "";
    teacher = json['teacher'] ?? "";
  }
}

class TodayLiveModel {
  String currentStatus;
  String meetingID;
  String subject;
  String msstatus;
  String joinurl;
  String scheduleDate;
  String scheduleTime;
  String endTime;
  String teacher;

  TodayLiveModel({
    this.currentStatus,
    this.meetingID,
    this.subject,
    this.msstatus,
    this.joinurl,
    this.scheduleDate,
    this.scheduleTime,
    this.endTime,
    this.teacher,
  });

  TodayLiveModel.fromJson(Map<String, dynamic> json) {
    currentStatus = json['current_status'] ?? "";
    meetingID = json['meetingID'] ?? "";
    subject = json['subject'] ?? "";
    // title = json['title'] ?? "";
    msstatus = json['mstatus'] ?? "";
    joinurl = json['join_url'] ?? "";
    scheduleDate = json['schedule_date'] ?? "";
    scheduleTime = json['schedule_time'] ?? "";
    endTime = json['end_time'] ?? "";
    teacher = json['teacher'] ?? "";
  }
}

class TodayLiveModelTeacher {
  String currentStatus;
  String meetingID;
  String subject;
  String msstatus;
  String joinurl;
  String scheduleDate;
  String scheduleTime;
  String endTime;
  String teacher;
  String section;

  TodayLiveModelTeacher({
    this.currentStatus,
    this.meetingID,
    this.subject,
    this.msstatus,
    this.joinurl,
    this.scheduleDate,
    this.scheduleTime,
    this.endTime,
    this.teacher,
    this.section,
  });

  TodayLiveModelTeacher.fromJson(Map<String, dynamic> json) {
    currentStatus = json['current_status'] ?? "";
    meetingID = json['meetingID'] ?? "";
    subject = json['subject'] ?? "";
    // title = json['title'] ?? "";
    msstatus = json['mstatus'] ?? "";
    joinurl = json['start_url'] ?? "";
    scheduleDate = json['schedule_date'] ?? "";
    scheduleTime = json['schedule_time'] ?? "";
    endTime = json['end_time'] ?? "";
    teacher = json['teacher'] ?? "";
    section = json['sectionID'] ?? "";
  }
}

class CompletedLiveModelTeacher {
  String subject;
  String msstatus;
  String joinurl;
  String scheduleDate;
  String scheduleTime;
  String endTime;
  String teacher;

  CompletedLiveModelTeacher({
    this.subject,
    this.msstatus,
    this.joinurl,
    this.scheduleDate,
    this.scheduleTime,
    this.endTime,
    this.teacher,
  });

  CompletedLiveModelTeacher.fromJson(Map<String, dynamic> json) {
    subject = json['subject'] ?? "";
    // title = json['title'] ?? "";
    msstatus = json['mstatus'] ?? "";
    joinurl = json['start_url'] ?? "";
    scheduleDate = json['schedule_date'] ?? "";
    scheduleTime = json['schedule_time'] ?? "";
    endTime = json['end_time'] ?? "";
    teacher = json['teacher'] ?? "";
  }
}

class UpcomingLiveModelTeacher {
  String subject;
  String msstatus;
  String joinurl;
  String scheduleDate;
  String scheduleTime;
  String endTime;
  String teacher;

  UpcomingLiveModelTeacher({
    this.subject,
    this.msstatus,
    this.joinurl,
    this.scheduleDate,
    this.scheduleTime,
    this.endTime,
    this.teacher,
  });

  UpcomingLiveModelTeacher.fromJson(Map<String, dynamic> json) {
    subject = json['subject'] ?? "";
    // title = json['title'] ?? "";
    msstatus = json['mstatus'] ?? "";
    joinurl = json['start_url'] ?? "";
    scheduleDate = json['schedule_date'] ?? "";
    scheduleTime = json['schedule_time'] ?? "";
    endTime = json['end_time'] ?? "";
    teacher = json['teacher'] ?? "";
  }
}
