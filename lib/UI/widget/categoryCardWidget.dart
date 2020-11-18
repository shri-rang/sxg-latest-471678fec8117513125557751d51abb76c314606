import 'package:flutter/material.dart';
import 'package:simple_x_genius/constant/colors.dart';

class CategoryCardWidget extends StatelessWidget {

 final VoidCallback onTap;
 final icon;
 final title;


  const CategoryCardWidget({Key key,  this.onTap, this.icon, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Card(
        
        elevation: 8.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: Icon(icon,color: defaultAppBlueColor,),
                ),
                SizedBox(
                  height: 4.0,
                ),
               
                Text(
                 title,
                  maxLines: 2,
                  textAlign: TextAlign.center,

                  style: TextStyle(
                      fontSize: 10.0,
                      letterSpacing: 0.2,

                      ),
                ),
                SizedBox(
                  height: 4.0,
                ),
             
              ],
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}