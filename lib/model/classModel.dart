class ClassModel{
  String classId;
  String className;
  String classNumeric;
  String creationDate;

  ClassModel.fromJson(Map<String,dynamic>map){
    classId=map['classesID']??"";
    className=map['classes']??"";
    classNumeric=map['classes_numeric']??"";
    creationDate=map['create_date']??"";
  }


}