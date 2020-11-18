class SectionModel{
  String sectionId;
  String classId;
  String sectionName;
  String teacherId;
  String notes;

  SectionModel.fromJson(Map<String,dynamic>map){
    sectionId=map['sectionID']??"";
    classId=map['classesID']??"";
    sectionName=map['section']??"";
    teacherId=map['teacherID']??"";
    notes=map['note']??"";
  }

}
