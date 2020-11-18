import 'package:flutter/cupertino.dart';
import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/chooseInboxSent.dart';
import 'package:simple_x_genius/api/networkApi/netWorkApi.dart';
import 'package:simple_x_genius/model/homeWorkDetailsModel.dart';

import 'dart:io' as Z;
class StudentCircularDetailsProvider extends ChangeNotifier {
  bool _loadingReply = false;
  bool _sentReplyLoading = false;

  bool get sentReplyLoading => _sentReplyLoading;

  set sentReplyLoading(bool sentReplyLoading) {
    _sentReplyLoading = sentReplyLoading;
  }

  bool get loadingReply => _loadingReply;

  List<ReplyMessage> replyMessages;
  SendMessage _sendMessage;

  SendMessage get sendMessage => _sendMessage;

  NetworkApiClient _networkApiClient = NetworkApiClient();
  Future setMessageReply(
      {String messageId,
      String title,
      String replyMessage,
      String status,
      String parentId,
      Z.File upfile}) async {
    sentReplyLoading = true;
    notifyListeners();

    await _networkApiClient.setReplyMessage(
        messageId: messageId,
        parentId: parentId,
        replyMessage: replyMessage,
        title: title,
        status: status,
        uploadedFile: upfile);

    sentReplyLoading = false;
    notifyListeners();
  }

  Future getCircularDetailsModel(String messageId, UIType uiType) async {
    _loadingReply = true;
    List<ReplyMessage> replys = [];
    _sendMessage = null;
    var response =
        await _networkApiClient.getReplyMesageFromServer(messageId, uiType);
    if (response["SXG"]["STATUS"]["STATUS"] == "1") {
      var data = response["SXG"]["reply_message"] as List;
      data.forEach((element) => {replys.add(ReplyMessage.fromJson(element))});
      replyMessages = replys;
      _sendMessage = SendMessage.fromMap(response["SXG"]['send_message'][0]);
    } else {
      replyMessages = [];
    }

    _loadingReply = false;
    notifyListeners();
  }
}
