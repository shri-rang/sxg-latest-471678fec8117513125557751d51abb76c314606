import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class StudentImageViewer extends StatelessWidget {
  String attachment;

  StudentImageViewer({this.attachment});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Viewer'),
      ),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage("$attachment"),
          loadFailedChild: CircularProgressIndicator(),
          loadingBuilder: (context, event) {
            return Center(child: CircularProgressIndicator());
          },
        ),
        // ),
      ),
    );
  }
}
