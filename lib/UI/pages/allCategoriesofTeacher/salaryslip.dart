import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SalarySlip extends StatefulWidget {
  final String id;

  SalarySlip({this.id});

  @override
  _SalarySlipState createState() => _SalarySlipState();
}

class _SalarySlipState extends State<SalarySlip> {
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
        title: Text('Salary Slip'),
      ),
      body: WebView(
        initialUrl:
            'http://theduncanacademy.com/Salary_template/salary_slip/$ids',
        // 'http://duncan.simplexgenius.in/new_student/monthly_report/$ids',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
