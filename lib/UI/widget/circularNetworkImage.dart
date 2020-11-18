import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double borderadius;
  final elevationCard;
CircularNetworkImageWidget({this.imageUrl, this.height, this.width, this.borderadius,this.elevationCard});  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(borderadius ?? 0.0),
        child: Card(
           shape: CircleBorder(),
    clipBehavior: Clip.antiAlias,
          elevation: elevationCard??0.0,
                  child: CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: imageUrl,
            placeholder: (_, url) => CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
          ),
        ),
      ),
    );
  }
}