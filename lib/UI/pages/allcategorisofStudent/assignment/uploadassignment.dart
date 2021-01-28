import 'package:flutter/cupertino.dart';
import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/chooseInboxSent.dart';
import 'package:simple_x_genius/api/networkApi/netWorkApi.dart';
import 'package:simple_x_genius/model/homeWorkDetailsModel.dart';
import 'dart:io' as Z;

class StudentUploadProvider {
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
  Future uploadAssignmentFile({
    String assignmentId,
    String studentId,
    Z.File uploadedFile,
    String fileName,
    String uploadMessage,
    // String fileExtention,
    // Z.File upfile
  }) async {
    // sentReplyLoading = true;
    // notifyListeners();
    print(uploadedFile);
    print(fileName);
    // print(fileExtention);
    var res = await _networkApiClient.uploadAssingment(
      assignmentId: assignmentId,
      studentId: studentId,
      uploadedFile: uploadedFile,
      fileName: fileName,
      uploadMessage: uploadMessage,
      // fileExtension: fileExtention
      // messageId: messageId,
      // parentId: parentId,
      // replyMessage: replyMessage,
      // title: title,
      // status: status,
      // uploadedFile: upfile
    );

    // sentReplyLoading = false;
    print('this is res : $res');
    return res;
    // notifyListeners();
  }
}
