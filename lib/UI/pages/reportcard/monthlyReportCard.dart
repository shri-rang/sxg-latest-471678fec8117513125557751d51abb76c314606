import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MonthlyReportCard extends StatefulWidget {
  final String id;
  // final Function toggleView;

  MonthlyReportCard({
    this.id,
  });

  @override
  _MonthlyReportCardState createState() => _MonthlyReportCardState();
}

class _MonthlyReportCardState extends State<MonthlyReportCard> {
  String id;

  Completer<WebViewController> _controller = Completer<WebViewController>();

  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    var ids = widget.id;

    return Scaffold(
      appBar: AppBar(
        title: Text('Term ReportCard'),
      ),
      body: WebView(
        initialUrl: 'http://theduncanacademy.com/new_student/reportcard/$ids',
        // 'http://duncan.simplexgenius.in/new_student/monthly_report/$ids',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
