import 'package:flutter/cupertino.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/model/classModel.dart';
import 'package:simple_x_genius/model/sectionModel.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';
import 'package:simple_x_genius/model/subjectmodel.dart';

class GetClassSectionProvider extends ChangeNotifier {
  final NetWorkAPiRepository netWorkAPiRepository;

  bool _loaderState = false;
  ClassModel _classModel;
  bool _dropDownLoader1 = false;

  bool get dropDownLoader1 => _dropDownLoader1;

  set dropDownLoader1(bool dropDownLoader1) {
    _dropDownLoader1 = dropDownLoader1;
    notifyListeners();
  }

  bool _dropDownLoader2 = false;

  bool get dropDownLoader2 => _dropDownLoader2;

  set dropDownLoader2(bool dropDownLoader2) {
    _dropDownLoader2 = dropDownLoader2;
    notifyListeners();
  }

  GetClassSectionProvider(this.netWorkAPiRepository);

  ClassModel get classModel => _classModel;

  set classModel(ClassModel classModel) {
    _classModel = classModel;
    notifyListeners();
  }

  StudentInfoModel _studentInfoModel;

  StudentInfoModel get studentInfoModel => _studentInfoModel;

  set studentInfoModel(StudentInfoModel studentInfoModel) {
    _studentInfoModel = studentInfoModel;
    notifyListeners();
  }

  SectionModel _sectionModel;

  SectionModel get sectionModel => _sectionModel;

  set sectionModel(SectionModel sectionModel) {
    _sectionModel = sectionModel;
    notifyListeners();
  }

  SubjectModel _subjectModel;

  SubjectModel get subjectModel => _subjectModel;

  set subjectModel(SubjectModel sectionModel) {
    _subjectModel = sectionModel;
    notifyListeners();
  }

  bool get loaderState => _loaderState;

  List<ClassModel> classModels = [];
  List<SectionModel> sectionModels = [];
  List<StudentInfoModel> _studentInfoModels = [];
  List<SubjectModel> subjectModels = [];
  List<StudentInfoModel> get studentInfoModels => _studentInfoModels;

  set studentInfoModels(List<StudentInfoModel> studentInfoModels) {
    _studentInfoModels = studentInfoModels;
    notifyListeners();
  }

  void setLoaderState(bool state) {
    _loaderState = state;
    // notifyListeners();
  }

  getClassDataModelProvider() async {
    var data = await netWorkAPiRepository.getClassDataModel();
    classModels = data;
    notifyListeners();
  }

  getSectionDataModelProvider(String classId) async {
    dropDownLoader1 = true;
    var data = await netWorkAPiRepository.getSectionDataModel(classId);
    sectionModels = data;
    notifyListeners();
    dropDownLoader1 = false;
  }

  getSubjetDataModelProvider(String classId) async {
    dropDownLoader1 = true;
    var data = await netWorkAPiRepository.getSubjectDataModel(classId);
    subjectModels = data;
    notifyListeners();
    dropDownLoader1 = false;
  }

  getStudentInfoModelProvider(
      {String classId, String sectionId, String name}) async {
    dropDownLoader2 = true;
    var data = await netWorkAPiRepository.getallStudentOfaSectionDataModel(
        classId: classId, name: name, sectId: sectionId);
    studentInfoModels = data;
    dropDownLoader2 = false;
  }
}
