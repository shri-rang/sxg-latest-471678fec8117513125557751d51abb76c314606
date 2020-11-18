import 'package:flutter/material.dart';
import 'package:simple_x_genius/UI/widget/newsLetterCard.dart';
import 'package:simple_x_genius/constant/colors.dart';

class NewsLetterPage extends StatefulWidget {
  @override
  _NewsLetterPageState createState() => _NewsLetterPageState();
}

class _NewsLetterPageState extends State<NewsLetterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          "NewsLetter",
          style: TextStyle(color: blackColor),
        ),
        iconTheme: IconThemeData(color: blackColor),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, int) {
              return NewsLetterCardWidget();
            }),
      ),
    );
  }
}
