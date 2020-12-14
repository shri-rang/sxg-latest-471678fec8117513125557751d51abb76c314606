import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_x_genius/UI/pages/allcategorisofStudent/categoryListPage.dart';
import 'package:simple_x_genius/UI/widget/errorDialougeWidget.dart';
import 'package:simple_x_genius/UI/widget/futureBuilderWidget.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/api/userTokenProvider.dart';
import 'package:simple_x_genius/constant/firebasecontroller.dart';
import 'package:simple_x_genius/model/stuentInfoModel.dart';
import 'package:simple_x_genius/model/youtubeVideo.dart';
import 'package:simple_x_genius/utility/tokenStoreUtil.dart';
import 'package:simple_x_genius/constant/registerNotification.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeParentPage extends StatefulWidget {
  final List<String> parentInfo;
  // final Function popUp;
  //  FirebaseMessaging firebaseMessaging;

  const HomeParentPage({
    Key key,
    this.parentInfo,
  }) : super(key: key);
  @override
  _HomeParentPageState createState() => _HomeParentPageState();
}

class _HomeParentPageState extends State<HomeParentPage> {
  NetWorkAPiRepository _netWorkAPiRepository;

  // @override
  // void setState(fn) {
  //   widget.popUp;
  //   // TODO: implement setState
  //   super.setState(fn);
  // }

  @override
  void initState() {
    _netWorkAPiRepository = NetWorkAPiRepository();

    // widget.popUp;
    // print(widget.parentInfo[0]);
    // print(widget.parentInfo[1]);
    print(widget.parentInfo[2]);
    super.initState();
    Future.delayed(Duration.zero, () {
      _showAlert(context);
    });
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => FutureBuilder<List<YoutubeVideo>>(
          future: _netWorkAPiRepository.viewYoutubeVideo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: 400,
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    String videoId;
                    videoId = YoutubePlayer.convertUrlToId(
                        "${snapshot.data[index].videoLink}");
                    print(videoId);
                    YoutubePlayerController _controller =
                        YoutubePlayerController(
                      initialVideoId: videoId == null ? 'No Vieo' : videoId,
                      flags: YoutubePlayerFlags(
                        autoPlay: true,
                        // mute: tru,
                        forceHD: false,
                      ),
                    );
                    return Container(
                      // height: 400,
                      // alignment: Alignment.center,
                      child: AlertDialog(
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Go Back'),
                          )
                        ],
                        title: Center(child: Text(snapshot.data[index].title)),
                        content: Container(
                          height: 300,
                          width: 400,
                          child: YoutubePlayerBuilder(
                              player: YoutubePlayer(
                                controller: _controller,
                              ),
                              builder: (context, player) {
                                return Column(
                                  children: [
                                    // some widgets
                                    Container(
                                        width: 400,
                                        height: 300,
                                        child: player == null
                                            ? Container()
                                            : player),
                                    // RaisedButton.icon(
                                    //   icon: Icon(Icons.close),
                                    //   onPressed: () {
                                    //     print(videoId);
                                    //     print(snapshot.data[index].videoLink);
                                    //     Navigator.canPop(context);
                                    //   },
                                    //   label: Text('Close'),
                                    // )
                                    // // //some other widgets
                                  ],
                                );
                                // ),
                              }),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ],
              );
              //   [

              // ];
            } else {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                    ),
                    // Center(
                    //   child: const Padding(
                    //     padding: EdgeInsets.only(top: 16),
                    //     child: CircularProgressIndicator(),
                    //   ),
                    // )
                  ]);
            }
          }),
      // )
    );
  }

  @override
  Widget build(BuildContext context) {
    var userTokendata = Provider.of<UserTokenProvider>(context, listen: false);
    return Scaffold(
      body: FutureBuilderWidget<List<StudentInfoModel>>(
          future:
              _netWorkAPiRepository.getStudentDataRepo(widget.parentInfo[2]),
          builder: (context, snapshot) {
            if (snapshot == null)
              return Center(
                child: Text("No internet connection"),
              );
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: DefaultTabController(
                  length: snapshot.length,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text("Parent"),
                      centerTitle: true,
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.exit_to_app),
                          onPressed: () {
                            buildAlertDialog(context, () async {
                              await StorageUtil.removeString('userInfo');
                              await userTokendata.removeUserToken('token');
                              Navigator.of(context).pop();
                            });
                          },
                        )
                      ],
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(40),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TabBar(
                            isScrollable: true,
                            tabs: snapshot
                                .map((i) => Tab(
                                      text: i.studenName.length > 5
                                          ? i.studenName.substring(0, 5)
                                          : i.studenName,
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),

                    body: new TabBarView(
                        children: snapshot
                            .map((studentInfo) => Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: CategoryListPage(
                                  id: studentInfo.studenId,
                                  phone: widget.parentInfo[2],
                                  studentInfoModel: studentInfo,
                                )))
                            .toList()),
                    // floatingActionButton: FloatingActionButton(
                    //     backgroundColor: defaultAppBlueColor,
                    //     mini: true,
                    //     child: Icon(Icons.power_settings_new),
                    //     onPressed: () async {
                    //       await StorageUtil.removeString('userInfo');
                    //       await userTokendata.removeUserToken('token');
                    //     }),
                  )),
            );
          }),
    );
  }
}
