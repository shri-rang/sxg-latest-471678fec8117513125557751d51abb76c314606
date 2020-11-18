import 'package:simple_x_genius/model/feesInvoiceInfoModel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class API_Manager {
  Future<FeeModel> getFee(String ids) async {
    var feeModel;
    print(ids);
    var client = http.Client();

    try {
      var response = await client.get(
          "http://duncanwebservice.theduncanacademy.com//Get_getfees.php?studentId=$ids");

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
}
