import 'dart:async';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TimeTable extends StatefulWidget {
  final String id;

  TimeTable({this.id});

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    var ids = widget.id;
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Table'),
      ),
      body: WebView(
        initialUrl:
            'http://theduncanacademy.com/timetable/teacher_timetable/$ids',
        // 'http://duncan.simplexgenius.in/new_student/monthly_report/$ids',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
