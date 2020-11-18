// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:simple_x_genius/UI/pages/reportcard/monthlyReportCard.dart';
// import 'package:simple_x_genius/UI/pages/reportcard/termRerpportCard.dart';
// import 'package:simple_x_genius/model/stuentInfoModel.dart';

// import 'package:simple_x_genius/UI/widget/blurBackgroundImageWidget.dart';
// import 'package:simple_x_genius/constant/colors.dart';

// import 'package:webview_flutter/webview_flutter.dart';

// import 'dart:io';



// class ReportCard extends StatefulWidget {

//   // final StudentInfoModel studentInfoModel;
//   String id;

//   ReportCard({this.id});

//   @override
//   _ReportCardState createState() => _ReportCardState();
// }

// class _ReportCardState extends State<ReportCard> {

//      bool showReport = true;
//   void toggleView(){
//     setState(() {
//       showReport =!showReport;
//     });
//   }

//     // void initState() {
//     // super.initState();
//     // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//   // }

//   // Completer<WebViewController> _controller = Completer<WebViewController>();

//   @override
//   Widget build(BuildContext context) {
    
//     String id;
//     id= widget.id;
     
  
//      if (showReport){
//      return TermReportCard(id: id,);
//    }else {
//      return MonthlyReportCard(id:id,);
//    }
//   }
// }




    // MaterialApp(  
    //   home: DefaultTabController(  
    //     length: 2,  
    //     child: Scaffold(  
    //       appBar: AppBar(  
            
    //         // title: Text('Gal'),  
    //         bottom:  TabBar(  
    //           // onTap: (val) {
    //           //    _launchURL();
    //           // },
    //           tabs: [  
                
    //             Tab(icon: Icon(Icons.receipt), text: "Report Card",
                
    //                ),  
    //             Tab(icon: Icon(Icons.receipt_long_outlined), text: "Monthly Report Card")  
    //           ],  
    //         ),  
    //       ),
       
    //       body: TabBarView( 
            
    //         children: [  
    //             TermReportCard(id: id,),
    //              MonthlyReportCard(id: id,),
            
    //         ],  
    //       ),  
    //     ),  
    //   ),  
    // );  





    // Scaffold(
    //     appBar: AppBar(
    //       title: Text('Report Card'),
    //     ),

    //     body: WebView(
              
    //   initialUrl: 'http://duncan.simplexgenius.in/new_student/reportcard/$id',
    //   javascriptMode: JavascriptMode.unrestricted,
    //    onWebViewCreated: (WebViewController webViewController){
    //      _controller.complete(webViewController);
    //    },
       
    // ),
  

    // );

  // }

// class WebViewExample extends StatelessWidget {
//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WebView(
//       initialUrl: 'https://flutter.dev',
//     );
//   }
// }




// class ReportCard extends StatefulWidget {
//   final String phoneNumber;
//   final bool isTeacher;

//   const ReportCard({Key key, this.phoneNumber,@required this.isTeacher}) : super(key: key);
//   @override
//   _ReportCardState createState() => _ReportCardState();
// }
// class _ReportCardState extends  State<ReportCard> {
//   @override

// Widget build(BuildContext context){
//   return

  
   
  // Stack(
    //   children: <Widget>[
    //     BlurBackgroundImageWidget(),
    //     Scaffold(
    //       backgroundColor: Colors.transparent,
    //       body: Form(
           
    //         child: Center(
              
    //           child: SingleChildScrollView(
    //             child: Container(
    //               margin: EdgeInsets.symmetric(horizontal: 20.0),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: <Widget>[
             
          

    //                   RaisedButton(
    //                      color: blueColor,
    //                       onPressed: () {
    //                         try
    //                         {
    //                         "sxgnew,simplexgenius.in";
    //                         }
    //                         catch(e)
    //                         {
    //                           print(e.toString());
    //                         }
    //                       },
    //                       child: Text(
    //                         "Click here ",
    //                         style: TextStyle(color: whiteColor,
    //      ), 
                            
    //                       ))


    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     )
    //   ],
    // );
  // }


//  }


  