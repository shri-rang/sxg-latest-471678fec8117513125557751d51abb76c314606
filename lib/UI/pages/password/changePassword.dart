import 'package:flutter/material.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/constant/colors.dart';
import 'package:simple_x_genius/utility/passwordvalidator.dart';

class ChangePassWord extends StatefulWidget {
  final String phoneNumber;
  final bool isTeacher;

  const ChangePassWord({Key key, this.phoneNumber,@required this.isTeacher}) : super(key: key);
  @override
  _ChangePassWordState createState() => _ChangePassWordState();
}

class _ChangePassWordState extends State<ChangePassWord> {
  final TextEditingController _controllerOldPass = new TextEditingController();
  final TextEditingController _controllerNewPass = new TextEditingController();
  final TextEditingController _controllerConfirmNewPass =
      new TextEditingController();
  NetWorkAPiRepository _netWorkAPiRepository = NetWorkAPiRepository();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _loader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding:widget.isTeacher,
      key: _scaffoldKey,
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          "Change Password",
          style: TextStyle(color: blackColor),
        ),
        iconTheme: IconThemeData(color: blackColor),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _controllerOldPass,
                  obscureText: true,
                  validator: (v) => Validator.passwordValidation(v),
                  decoration: InputDecoration(hintText: "Enter Old Password"),
                ),
                TextFormField(
                  controller: _controllerNewPass,
                  obscureText: true,
                  validator: (v) => Validator.passwordValidation(v),
                  decoration: InputDecoration(hintText: "Enter New Password"),
                ),
                TextFormField(
                  controller: _controllerConfirmNewPass,
                  obscureText: true,
                  validator: (v) => Validator.passwordValidation(
                    v,
                  ),
                  decoration: InputDecoration(
                    hintText: "Confirm New Password",
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                _loader
                    ? CircularProgressIndicator()
                    : RaisedButton(
                        color: blueColor,
                        textColor: whiteColor,
                        child: Text("Continue"),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            if (_controllerNewPass.text ==
                                _controllerConfirmNewPass.text) {
                              setState(() {
                                _loader = true;
                              });

                              var response = await _netWorkAPiRepository
                                  .changePasswordRepo(
                                      phoneNumber: widget.phoneNumber,
                                      newPassword:
                                          _controllerConfirmNewPass.text,
                                      oldPassword: _controllerOldPass.text);
                              setState(() {
                                _loader = false;
                              });

                              _showSnackbarMessage(response);

                             if(response) Future.delayed(Duration(seconds: 2),(){
                                Navigator.of(context).pop();
                              } );
                            } else {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  backgroundColor: redColor,
                                  duration: Duration(seconds: 2),
                                  content: Text("Password doesn't match")));
                            }
                          }
                        },
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackbarMessage(bool response) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: response ? greenColor : redColor,
      content: Text(response
          ? "Password Changed Successfully"
          : "Check your old password"),
      duration: Duration(seconds: 2),
    ));
  }
}



