import 'dart:async';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
  WebViewController controllerGlobal;
  // String id;
  InAppWebViewController webView;
  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      print("onwill goback");
      controllerGlobal.goBack();
    } else {
      Scaffold.of(context).showSnackBar(
        const SnackBar(content: Text("No back history item")),
      );
      return Future.value(false);
    }
  }

  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    var ids = widget.id;

    return Scaffold(
      appBar: AppBar(
        title: Text('Term ReportCard'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            // Container(
            //   padding: EdgeInsets.all(20.0),
            //   child: Text(
            //       "CURRENT URL\n${(url.length > 50) ? url.substring(0, 50) + "..." : url}"),
            // ),
            SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: progress < 1.0
                      ? LinearProgressIndicator(value: progress)
                      : Container()),
            ),
            Expanded(
              child: Container(
                // margin: const EdgeInsets.all(10.0),
                // decoration:
                //     BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: InAppWebView(
                  initialUrl:
                      "http://theduncanacademy.com/new_student/reportcard/$ids",
                  initialHeaders: {},
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                    debuggingEnabled: true,
                    supportZoom: true,
                    javaScriptEnabled: true,

                    // applicationNameForUserAgent:
                    //     "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36",
                    // userAgent:
                    //     "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36",
                    // private static final String MOBILE_USER_AGENT = "Mozilla/5.0 (Linux; U; Android 4.4; en-us; Nexus 4 Build/JOP24G) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30",
                  )
                      // android: InApp
                      ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webView = controller;
                  },
                  onLoadStart: (InAppWebViewController controller, String url) {
                    setState(() {
                      this.url = url;
                    });
                  },
                  onLoadStop:
                      (InAppWebViewController controller, String url) async {
                    setState(() {
                      this.url = url;
                    });
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () {
                    if (webView != null) {
                      webView.goBack();
                    }
                  },
                ),
                RaisedButton(
                  child: Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (webView != null) {
                      webView.goForward();
                    }
                  },
                ),
                RaisedButton(
                  child: Icon(Icons.refresh),
                  onPressed: () {
                    if (webView != null) {
                      webView.reload();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//  WebView(
//         initialUrl: 'http://theduncanacademy.com/new_student/reportcard/$ids',
//         // 'http://duncan.simplexgenius.in/new_student/monthly_report/$ids',
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller.complete(webViewController);
//         },
//       ),
