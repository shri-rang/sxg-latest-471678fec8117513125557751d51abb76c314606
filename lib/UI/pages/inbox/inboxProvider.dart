import 'package:flutter/cupertino.dart';
import 'package:simple_x_genius/api/networkApi/netWorkApi.dart';
import 'package:simple_x_genius/model/inboxModel.dart';

class InBoxProvider extends ChangeNotifier{
    NetworkApiClient _networkApiClient = NetworkApiClient();
    bool _loadingInfo=false;

  bool get loadingInfo => _loadingInfo;

    List<InboxModel>_inboxInfos;

  List<InboxModel> get inboxInfos => _inboxInfos;


    Future getInbox(String uid,bool isHomeWork)async{
         List<InboxModel>tempInfo=[];
      _loadingInfo=true;
   var response  =await _networkApiClient.getInboxMessages(uid,isHomeWork);


      if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["homework_data"] as List;
      
      data.forEach((element) => {tempInfo.add(InboxModel.fromJson(element))});
      
    } else {
      tempInfo=[];
    }
    _inboxInfos=tempInfo;
     _loadingInfo=false;
    notifyListeners();

    }

}