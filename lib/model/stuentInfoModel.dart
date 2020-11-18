class StudentInfoModel {
  String studenName;
  String studenId;
  String dob;
  String sex;
  String religion;
  String photo;
  String classesID;
  String sectionID;
  String email;
  String address;
  String roll;
  String nationality;
  String adharNo;
  String regNum;
  String admNo;
  String motherTongue;
  String blood;

  StudentInfoModel.fromMap(Map<String, dynamic> data)
      : studenName = data['name'],
        studenId = data['studentID'],
        dob = data['dob'],
        sex = data['sex'],
        religion = data['religion'],
        photo = data['photo'],
        classesID = data['classesID'],
        sectionID = data['sectionID'],
        email = data['email'],
        address = data['address'],
        roll = data['roll'],
        nationality = data['nationality'],
        adharNo = data['adhar_no'],
        regNum = data['reg_num'],
        admNo = data['adm_no'],
        motherTongue = data['mother_tongue'],
        blood = data['blood'];
}
