// import 'package:flutter/material.dart';
// import 'package:simple_x_genius/model/stuentInfoModel.dart';
// import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
// import 'package:simple_x_genius/model/viewassignmentModel.dart';

// class ViewStudentAssignment extends StatefulWidget {
//   final StudentInfoModel studentInfoModel;

//   ViewStudentAssignment({this.studentInfoModel});

//   @override
//   _ViewStudentAssignmentState createState() => _ViewStudentAssignmentState();
// }

// class _ViewStudentAssignmentState extends State<ViewStudentAssignment> {
//   NetWorkAPiRepository _netWorkAPiRepository;
//   @override
//   void initState() {
//     _netWorkAPiRepository = NetWorkAPiRepository();

//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // var classesId = widget.studentInfoModel.classesID;
//     // var sectionId = widget.studentInfoModel.sectionID;
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: RaisedButton(
//       //     onPressed: () {
//       //       print(widget.teacherId);
//       //     },
//       //   ),
//       // ),
//       body: FutureBuilder<List<ViewAssignmentModel>>(
//         future: _netWorkAPiRepository.viewStudentAssignments(
//             widget.studentInfoModel.classesID,
//             widget.studentInfoModel.sectionID),
//         builder: (context, AsyncSnapshot<List<ViewAssignmentModel>> snapshot) {
//           // Container(
//           //   child: Text(snapshot.data.),
//           // );
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (context, index) {
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       // shape:
//                       // ShapeBorder(

//                       // ),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Color.fromRGBO(169, 235, 224, 1),
//                             // 169, 235, 224
//                             border: Border.all(
//                               color: Color.fromRGBO(78, 96, 98, 0.6),
//                             ),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(25))),
//                         // color: Colors.deepOrange,
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: 15,
//                             ),
//                             Text(
//                               'Title: ${snapshot.data[index].title}',
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               'Message: ${snapshot.data[index].message}',
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   height: 40,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: RaisedButton(
//                                       color: Colors.blue,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(3.0),
//                                         child: Text(
//                                           'Download',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             //  fontSize: 20
//                                           ),
//                                         ),
//                                       ),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(25.0),
//                                         // side: BorderSide(color: Colors.red)
//                                       ),
//                                       onPressed: () {
//                                         // Navigator.of(context).push(MaterialPageRoute(
//                                         //   builder: (context) => AddQuestions(),
//                                         // ));
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 40,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: RaisedButton(
//                                       color: Colors.blue,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(3.0),
//                                         child: Text(
//                                           'View Assignment',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             //  fontSize: 20
//                                           ),
//                                         ),
//                                       ),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(25.0),
//                                         // side: BorderSide(color: Colors.red)
//                                       ),
//                                       onPressed: () {
//                                         // Navigator.of(context).push(MaterialPageRoute(
//                                         //   builder: (context) => AddQuestions(),
//                                         // ));
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 5,
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),

//                   //  ListTile(
//                   //   trailing: Text('View Image'),
//                   //   title: Text(snapshot.data[index].title),
//                   //   subtitle: Text(snapshot.data[index].message),
//                   // ),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Column(
//               children: [
//                 Icon(
//                   Icons.error_outline,
//                   color: Colors.red,
//                   size: 60,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: Text('Error: ${snapshot.error}'),
//                 )
//               ],
//             );
//             //   [

//             // ];
//           } else {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Center(
//                   child: SizedBox(
//                     child: CircularProgressIndicator(),
//                     width: 60,
//                     height: 60,
//                   ),
//                 ),
//                 Center(
//                   child: const Padding(
//                     padding: EdgeInsets.only(top: 16),
//                     child: Text('Awaiting result...'),
//                   ),
//                 )
//               ],
//             );
//             //   <Widget>[

//             // ];
//           }
//           // return Center(
//           //   child: Column(
//           //     mainAxisAlignment: MainAxisAlignment.center,
//           //     crossAxisAlignment: CrossAxisAlignment.center,
//           //     children: children,
//           //   ),
//           // );
//         },
//       ),
//     );

//     // },
//     // )
//     // );
//     // ;
//   }
// }
