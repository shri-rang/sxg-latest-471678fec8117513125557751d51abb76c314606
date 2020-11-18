import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import './firebasecontroller.dart';

import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/chooseInboxSent.dart';
import 'package:simple_x_genius/UI/pages/studentCircular/studentCircularList.dart';
import 'package:simple_x_genius/api/networkApi/netWorkApi.dart';

final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();
NetworkApiClient networkApiClient = NetworkApiClient();
void registerNotification() {
  firebaseMessaging.requestNotificationPermissions();

  // FirebaseController.instanace.getUnreadMSGCount();
  firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
    // print('onMessage: $message');
    showNotification(message['notification']);
    // couter(message);
    return;
  }, onResume: (Map<String, dynamic> message) {
    // print('onResume: $message');
    return;
  }, onLaunch: (Map<String, dynamic> message) {
    //  print('onLaunch: $message');
    return;
  });
}

updateDeviceToken(
    {@required currentUserType, @required phoneNumber, @required context}) {
  firebaseMessaging.getToken().then((token) {
    //print('token: $token');
    networkApiClient.updateToken(
        number: phoneNumber,
        token: token,
        type: currentUserType == "Teacher" ? "teachers" : "parents");
  }).catchError((err) {
    print(err.message.toString());
  });
}

void configLocalNotification() {
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = new IOSInitializationSettings();
  var initializationSettings = new InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNoti);
}

Future onSelectNoti(String payload) async {
  //Navigator.of(context).build(context)
}

void showNotification(message) async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    Platform.isAndroid
        ? 'com.softdeveloper.simple_x_genius'
        : 'com.softdeveloper.simpleXGenius',
    'simpleXGenius',
    '',
    channelShowBadge: true,
    playSound: true,
    enableVibration: true,
    importance: Importance.Max,
    priority: Priority.High,
  );
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(0, message['title'].toString(),
      message['body'].toString(), platformChannelSpecifics,
      payload: json.encode(message));
}
