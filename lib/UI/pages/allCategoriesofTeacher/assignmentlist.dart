import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/model/assignlistmodel.dart';
import 'package:simple_x_genius/api/networkApi/api_maneger.dart';

class AssignmentListStudent extends StatefulWidget {
  final String studentId;
  final String assigmentId;

  AssignmentListStudent({this.studentId, this.assigmentId});
  @override
  _AssignmentListStudentState createState() => _AssignmentListStudentState();
}

class _AssignmentListStudentState extends State<AssignmentListStudent> {
  // NetWorkAPiRepository _netWorkAPiRepository;
  Future<ListModel> _listModel;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   _netWorkAPiRepository = NetWorkAPiRepository();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    String studentId;
    String assigmentId;
    studentId = widget.studentId;

    _listModel = API_Manager()
        .getAssignList(studentId: studentId, assignmentId: assigmentId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Assginment'),
      ),
      body: Container(
        child: Column(
          children: [
            FutureBuilder<ListModel>(
              future: _listModel,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.sxg.assignment.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Card(
                          child: Column(
                            children: [
                              Text(snapshot
                                  .data.sxg.assignment[index].studentId),
                              Image.network(
                                  snapshot.data.sxg.assignment[index].docFile)
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return RaisedButton(
                    onPressed: () {
                      print(snapshot.data);
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
