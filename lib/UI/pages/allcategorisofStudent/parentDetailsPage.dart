import 'package:flutter/material.dart';
import 'package:simple_x_genius/UI/widget/customAppBarProfile.dart';
import 'package:simple_x_genius/UI/widget/futureBuilderWidget.dart';
import 'package:simple_x_genius/UI/widget/infoTileWidget.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/model/parentsInfoModel.dart';
import 'package:simple_x_genius/utility/tokenStoreUtil.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';

class ParentDetailsPage extends StatefulWidget {
  final String id;
  final StudentInfoModel studentInfoModel;

  ParentDetailsPage({
    this.id,
    this.studentInfoModel,
  });

  @override
  _ParentDetailsPageState createState() => _ParentDetailsPageState();
}

class _ParentDetailsPageState extends State<ParentDetailsPage> {
  NetWorkAPiRepository _netWorkAPiRepository;

  @override
  void initState() {
    _netWorkAPiRepository = NetWorkAPiRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(StorageUtil.getListString('userInfo')[0]);
    return Scaffold(
        // appBar: AppBar(
        //   actions: [
        //     // RaisedButton(
        //     //   onPressed: () {
        //     //     print(widget.id);
        //     //     print(widget.studentInfoModel.parentId);
        //     //   },
        //     // )
        //   ],
        // ),
        body:
            // StorageUtil.getListString('userInfo').isNotEmpty
            // ?
            FutureBuilderWidget<ParensInfoModel>(
      future: widget.studentInfoModel.parentId == null
          ? _netWorkAPiRepository
              .getParentInfoRepo(widget.studentInfoModel.studenId)
          : _netWorkAPiRepository
              .getStParentInfoRepo(widget.studentInfoModel.parentId),
      builder: (BuildContext context, parentData) {
        if (parentData == null) {
          return Center(
            child: Text("No data found"),
          );
        }

        return Scaffold(
          appBar: customAppBarProfile(
              backTap: () {
                Navigator.of(context).pop();
              },
              imageUrl: parentData.photo),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Text(
                      "Parent Information",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 10.0,
                  ),
                  InfoTileWIdget(
                      title: "Father's Name", value: parentData.fatherName),
                  InfoTileWIdget(
                    title: "Mother's Name",
                    value: parentData.motherName,
                  ),
                  InfoTileWIdget(
                    title: "Father's Profession",
                    value: parentData.fatherProfession,
                  ),
                  InfoTileWIdget(title: "Phone No", value: parentData.phone),
                  InfoTileWIdget(
                      title: "Mother's Phone No",
                      value: parentData.motherPhone),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    )
        // : Container(
        //     child: Center(
        //       child: Text("No inforamtion found"),
        //     ),
        //   ),
        );
  }
}
