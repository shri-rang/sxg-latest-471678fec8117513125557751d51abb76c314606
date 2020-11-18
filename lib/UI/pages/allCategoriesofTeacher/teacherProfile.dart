import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_x_genius/UI/widget/customAppBarProfile.dart';
import 'package:simple_x_genius/UI/widget/infoTileWidget.dart';
import 'package:simple_x_genius/constant/colors.dart';
import 'package:simple_x_genius/model/teacherInfoModel.dart';

class TeacherProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

   return Consumer<TeacherInfoModel>(builder: (_, profileData, child){
     return profileData!=null? Scaffold(
      backgroundColor: whiteColor,
      appBar: customAppBarProfile(backTap: () {
        Navigator.of(context).pop();
      },
      imageUrl: profileData.photo
      ),
      body: Consumer<TeacherInfoModel>(builder: (_, profileData, child) {
        return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                     SizedBox(height: 10.0,),
                      InfoTileWIdget(title:"Teacher name",value:profileData.name),
                      InfoTileWIdget(title:"Designation",value:profileData.designation),
                     
                      InfoTileWIdget(title:"DOB",value:profileData.dob),
                      InfoTileWIdget(title:"Phone",value:profileData.phone),
                      InfoTileWIdget(title:"Email",value:profileData.email),
                      InfoTileWIdget(title:"Gender",value:profileData.sex),
                      InfoTileWIdget(title:"Religion",value:profileData.religion),
                      InfoTileWIdget(title:"Address",value:profileData.address),
                    
                    ],
                  ),
                ),
              );
      }),
    ):Scaffold(
      body: Container(),
    );
   });
   
  }


}
