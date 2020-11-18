import 'dart:async';
// import 'dart:io';
// import 'dart:io' show Directory, Platform;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// import 'package:printing/printing.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter/material.dart';
import 'package:simple_x_genius/UI/pages/reportcard/monthlyReportCard.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class TermReportCard extends StatefulWidget {
  final String id;
  //  final Function toggleView;

  TermReportCard({
    this.id,
  });

  @override
  _TermReportCardState createState() => _TermReportCardState();
}

class _TermReportCardState extends State<TermReportCard> {
  String id;
  InAppWebViewController webView;

  String url = "";
  double progress = 0;

  //  String url = 'http://duncan.simplexgenius.in/new_student/reportcard/$ids';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //   if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  // }

  // Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    var ids = widget.id;

    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly ReportCard'),
        actions: [
          FlatButton.icon(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => MonthlyReportCard(
                        id: ids,
                      )));
              // widget.toggleView();
            },
            icon: Icon(
              Icons.receipt,
              size: 15,
            ),
            label: Text(
              'Term Report',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
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
                      "http://theduncanacademy.com/new_student/monthly_report/$ids",
                  initialHeaders: {},
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                    debuggingEnabled: true,
                  )),
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

  // WebView(
  //     initialUrl:
  //         'http://theduncanacademy.com/new_student/monthly_report/$ids',
  //     // "http://duncan.simplexgenius.in/new_student/reportcard/$ids",
  //     //  http://theduncanacademy.com/new_student/monthly_report/1
  //     javascriptMode: JavascriptMode.unrestricted,

  //     onWebViewCreated: (WebViewController webViewController) {
  //       _controller.complete(webViewController);
  //     },
  //   ),
  //   floatingActionButton:
  //       // Column(
  //       //     mainAxisAlignment: MainAxisAlignment.center,
  //       //   children: [
  //       //        _bookmarkButton(),
  //       //        FloatingActionButton(
  //       //          onPressed:(){
  //       //            print(url);
  //       //             // _requestDownload(
  //       //             //   url,
  //       //             //   // print(url);
  //       //             // );
  //       //          }
  //       //        )
  //       // ],)

  //       FutureBuilder<WebViewController>(
  //           future: _controller.future,
  //           builder: (BuildContext context,
  //               AsyncSnapshot<WebViewController> controller) {
  //             if (controller.hasData) {
  //               return FloatingActionButton(
  //                 onPressed: () async {
  //                   controller.data.reload();
  //                   print(controller.data);
  //                 },
  //                 child: const Icon(Icons.refresh),
  //               );
  //             }
  //             return Container();
  // })
}
