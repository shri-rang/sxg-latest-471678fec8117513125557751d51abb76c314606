class TeacherInfoModel {
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
  String pan;
  String lastLogin;
  String department;
  String adhar;
  String caste;
  String epfAc;
  String fname;
  String maritalstatus;
  String bloodgroup;
  String econtact;
  String emailschool;

  TeacherInfoModel.fromJson(Map<String, dynamic> json) {
    teacherId = json['teacherID'] ?? "";
    designation = json['designation'] ?? "";
    name = json['name'] ?? "";
    employeeId = json['emp_id'] ?? "";
    dob = json['dob'] ?? "";
    sex = json['sex'] ?? "";
    religion = json['religion'] ?? "";
    email = json['email'] ?? "";
    phone = json['phone'] ?? "";
    photo = json['photo'] ?? "";
    job = json['jod'] ?? "";
    userType = json['usertype'] ?? "";
    permissionId = json['permission_id'] ?? "";
    sign = json['sign'] ?? "";
    address = json['address'] ?? "";
    pan = json['pan'] ?? "";
    lastLogin = json['lastLogin'] ?? "";
    department = json['department'] ?? "";
    adhar = json['adhar'] ?? "";
    caste = json['caste'] ?? "";
    epfAc = json['epfAc'] ?? "";
    fname = json['fname'] ?? "";
    maritalstatus = json['maritalstatus'] ?? "";
    bloodgroup = json['bloodgroup'] ?? "";
    // bloodgroup=json['photo']??"";
    econtact = json['econtact'] ?? "";
    emailschool = json['emailschool'] ?? "";
  }
}

// class AdditionalInfoData {

//   AdditionalInfoData.fromJson(Map<String, dynamic> json) {

//   }
// }
