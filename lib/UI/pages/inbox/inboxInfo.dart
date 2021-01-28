import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_x_genius/UI/pages/allCategoriesofTeacher/chooseInboxSent.dart';
import 'package:simple_x_genius/UI/pages/studentCircular/studentCircularDetails.dart';
import 'package:simple_x_genius/constant/colors.dart';

import 'inboxProvider.dart';

class InboxInfo extends StatefulWidget {
  final String uid;
  final bool isHomeWork;

  const InboxInfo({Key key, this.uid, this.isHomeWork}) : super(key: key);
  @override
  _InboxInfoState createState() => _InboxInfoState();
}

class _InboxInfoState extends State<InboxInfo> {
  @override
  void initState() {
    var data = Provider.of<InBoxProvider>(context, listen: false);
    data.getInbox(widget.uid, widget.isHomeWork);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text("Inbox", style: TextStyle(color: blackColor)),
        iconTheme: IconThemeData(color: blackColor),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Consumer<InBoxProvider>(
        builder: (context, info, child) => Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child:
                // info.loadingInfo == null
                //     ? Center(
                //         child: Text('Now Not Available'),
                //       )
                info.loadingInfo
                    ? Center(
                        child: Column(
                          children: [
                            Text('Now Not Available'),
                            CircularProgressIndicator(),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: info.inboxInfos.length,
                        itemBuilder: (context, index) {
                          var data = info.inboxInfos[index];
                          return Card(
                            elevation: 4.0,
                            child: InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("From:\t" +
                                        data.from +
                                        "\tTo:\t" +
                                        data.to),
                                    Divider(),
                                    Text("Title:\t" + data.title),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Text("Message:\t" + data.replyMsg),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        data.createTime,
                                        style: TextStyle(
                                          color: greyColor,
                                          fontSize: 11.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        StudentCircularDetails(
                                          // studentInfoModel: widget.,
                                          messageId: data.messageID,
                                          readStatus: data.status,
                                          viewType: widget.isHomeWork
                                              ? UIType.HomeWOrk
                                              : UIType.DairyNotes,
                                          isTeacher: true,
                                          uid: widget.uid,
                                        )));
                              },
                            ),
                          );
                        },
                      )),
      ),
    );
  }
}
