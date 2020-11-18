import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddMarks extends StatefulWidget {
  final String id;

  AddMarks({this.id});

  @override
  _AddMarksState createState() => _AddMarksState();
}

class _AddMarksState extends State<AddMarks> {
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Marks'),
      ),
      body: WebView(
        initialUrl: 'http://theduncanacademy.com/exam/add_marks',
        // 'http://duncan.simplexgenius.in/new_student/monthly_report/$ids',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
