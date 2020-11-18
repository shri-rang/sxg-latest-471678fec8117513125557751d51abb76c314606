import 'package:flutter/material.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/constant/colors.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showingPhoneInput = true;
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerPin = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  final TextEditingController _controllerConfirmPass = TextEditingController();

  bool _loader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          "Forgot Password",
          style: TextStyle(color: blackColor),
        ),
        iconTheme: IconThemeData(color: blackColor),
        centerTitle: true,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print(_controllerPhone.text);
          
        },
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _showingPhoneInput
                  ? TextFormField(
                      controller: _controllerPhone,
                      decoration:
                          InputDecoration(hintText: "Enter Phone Number"),
                    )
                   
                  : TextFormField(
                      controller: _controllerPin,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "Enter OTP code"),
                    ),
              Visibility(
                visible: !_showingPhoneInput,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _controllerPass,
                      obscureText: true,
                      decoration:
                          InputDecoration(hintText: "Enter new Password"),
                    ),
                    TextFormField(
                      controller: _controllerConfirmPass,
                      obscureText: true,
                      decoration:
                          InputDecoration(hintText: "Confirm new Password"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              _loader
                  ? CircularProgressIndicator()
                  : RaisedButton(
                      color: blueColor,
                      textColor: whiteColor,
                      child: Text("Continue"),
                      onPressed: () async {
                        print(_controllerPhone.text.trim());
                        if (_showingPhoneInput) {
                          if (_controllerPhone.text.isEmpty) {
                            _showSnackbarMessage(false, "Enter phone number");
                          } else {
                            //send otp to phone

                            setLoaderState(true);
                            var response = await NetWorkAPiRepository()
                                .forgotPassPhoneAuthRepo(
                              _controllerPhone.text,
                          
                            );
                            setLoaderState(false);
                            if (response) {
                              setState(() {
                                _showingPhoneInput = false;
                              });
                            } else {
                              //otp sending to number failed
                              _showSnackbarMessage(
                                  false, "invalid user Number");
                            }
                          }
                        } else {
                          //otp received section
                          if (_controllerPin.text.isEmpty) {
                            _showSnackbarMessage(false, "Enter OTP code");
                          } else {
                            if (_controllerPass.text.isEmpty) {
                              _showSnackbarMessage(false, "Enter new password");
                            } else {
                              if (_controllerConfirmPass.text.isEmpty) {
                                _showSnackbarMessage(
                                    false, "Enter confirm password");
                              } else {
                                if (_controllerPass.text ==
                                    _controllerConfirmPass.text) {
                                  setLoaderState(true);

                                  var response = await NetWorkAPiRepository()
                                      .forgotPasswordRepo(
                                          otp: _controllerPin.text,
                                          phoneNumber: _controllerPhone.text,
                                          newPassword:
                                              _controllerConfirmPass.text);

                                  setLoaderState(false);

                                  if (response is String) {
                                    _showSnackbarMessage(false, response);
                                  }
                                  if (response is bool) {
                                    _showSnackbarMessage(
                                        true, "successfully changed password");
                                    if (mounted) {
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.of(context).pop();
                                      });
                                    }
                                  } else {}
                                } else {
                                  _showSnackbarMessage(
                                      false, "Password doesn't match");
                                }
                              }
                            }
                          }
                        }
                      }),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackbarMessage(bool response, message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: response? greenColor : redColor,
          content: Text(message),
          duration: Duration(seconds: 2),
        )
      );
    // _scaffoldKey.currentState.showSnackBar(SnackBar(
    //   backgroundColor: response ? greenColor : redColor,
    //   content: Text(message),
    //   duration: Duration(seconds: 2),
    // ));
  }

  void setLoaderState(bool state) {
    setState(() {
      _loader = state;
    });
  }
}
