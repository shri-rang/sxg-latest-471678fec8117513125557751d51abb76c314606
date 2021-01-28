import 'package:simple_x_genius/model/feesInvoiceInfoModel.dart';
import 'package:simple_x_genius/model/assignlistmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class API_Manager {
  Future<FeeModel> getFee(String ids) async {
    var feeModel;
    print(ids);
    var client = http.Client();

    try {
      var response = await client.get(
          "https://www.edwardses.net/edwardswebservice/Get_getfees.php?studentId=$ids");

      if (response.statusCode == 200) {
        var jsonString = response.body;

        var jsonMap = json.decode(jsonString);
        feeModel = FeeModel.fromJson(jsonMap);
      }
    } catch (Execption) {
      return feeModel;
    }
    return feeModel;
  }

  Future<ListModel> getAssignList(
      {String studentId, String assignmentId}) async {
    var listModel;
    // print(ids);
    var client = http.Client();

    try {
      var response = await client.get(
          "https://www.edwardses.net/edwardswebservice/Get_assignmentuploadbystudentid.php?studentID=$studentId&assignmentID=$assignmentId");

      if (response.statusCode == 200) {
        var jsonString = response.body;

        var jsonMap = json.decode(jsonString);
        listModel = ListModel.fromJson(jsonMap);
        print(listModel);
      }
    } catch (Execption) {
      return listModel;
    }
    return listModel;
  }
}
