import 'dart:async';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter/material.dart';
import 'package:simple_x_genius/UI/pages/reportcard/monthlyReportCard.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';
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
  // InAppWebViewController webView;

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

  Completer<WebViewController> _controller = Completer<WebViewController>();

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
      body: WebView(
        initialUrl:
            'http://theduncanacademy.com/new_student/monthly_report/$ids',
        // "http://duncan.simplexgenius.in/new_student/reportcard/$ids",
        //  http://theduncanacademy.com/new_student/monthly_report/1
        javascriptMode: JavascriptMode.unrestricted,

        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
