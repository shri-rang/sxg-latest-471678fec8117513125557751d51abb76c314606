class TeacherInfoModel{
  String teacherId;
  String designation;
  String name;
  String employeeId;
  String dob;
  String sex;
  String religion;
  String email;
  String phone;
  String photo;
  String job;
  String userType;
  String permissionId;
  String sign;
  String address;

  TeacherInfoModel.fromJson(Map<String,dynamic>json){
    teacherId=json['teacherID']??"";
    designation=json['designation']??"";
    name=json['name']??"";
    employeeId=json['emp_id']??"";
    dob=json['dob']??"";
    sex=json['sex']??"";
    religion=json['religion']??"";
    email=json['email']??"";
    phone=json['phone']??"";
    photo=json['photo']??"";
    job=json['jod']??"";
    userType=json['usertype']??"";
    permissionId=json['permission_id']??"";
    sign=json['sign']??"";
    address=json['address']??"";

  }
}


