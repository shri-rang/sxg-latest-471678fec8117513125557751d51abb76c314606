class ParensInfoModel{
  String parentID;
  String fatherName;
  String motherName;
  String phone;
  String fatherProfession;
  String photo;
  String motherPhone;

  ParensInfoModel.fromMap(Map<String,dynamic>data):
  parentID=data["parentID"]??"",
  fatherName=data["father_name"]??"",
  motherName=data["mother_name"]??"",
  phone=data["phone"]??"",
  fatherProfession=data["father_profession"]??"",
  motherPhone=data['mother_phone']??"",
  photo=data["photo"]??"";

}

