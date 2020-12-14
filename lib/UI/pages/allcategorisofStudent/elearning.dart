import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class Elearning extends StatefulWidget {
  @override
  _ElearningState createState() => _ElearningState();
}

class _ElearningState extends State<Elearning> {
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Classes'),
      ),
      body: WebView(
        initialUrl: 'https://interactives.school-network.net',
        // 'http://duncan.simplexgenius.in/new_student/monthly_report/$ids',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
