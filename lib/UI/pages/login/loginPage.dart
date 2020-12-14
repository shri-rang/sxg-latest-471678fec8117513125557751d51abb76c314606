import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_x_genius/UI/pages/password/forgotPasswordPage.dart';
import 'package:simple_x_genius/UI/widget/blurBackgroundImageWidget.dart';
import 'package:simple_x_genius/UI/widget/errorDialougeWidget.dart';
import 'package:simple_x_genius/UI/widget/progressIndicatorWidget.dart';
import 'package:simple_x_genius/api/networkApi/nerWorkApiRepository.dart';
import 'package:simple_x_genius/api/userTokenProvider.dart';
import 'package:simple_x_genius/constant/colors.dart';
import 'package:simple_x_genius/utility/validator.dart';

import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart'; //Added code for Whatsapp support

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loaderState = false;
  NetWorkAPiRepository _netWorkAPiRepository = NetWorkAPiRepository();
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    var userTokendata = Provider.of<UserTokenProvider>(context, listen: false);

    return Stack(
      children: <Widget>[
        BlurBackgroundImageWidget(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                          radius: 50.0,
                          backgroundColor: whiteColor,
                          backgroundImage:
                              AssetImage('assets/images/app_logo.png')),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Edwards English School",
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold),
                          )),
                      Card(
                        color: defaultAppBlueColor.withOpacity(0.5),
                        child: Container(
                          margin: EdgeInsets.all(3.0),
                          child: TextFormField(
                            controller: _controllerName,
                            style: TextStyle(
                                color: whiteColor, fontWeight: FontWeight.bold),
                            validator: (v) => Validator.commonValidation(
                                v, "User Name can't be empty"),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: whiteColor,
                              ),
                              hintText: "Your Username",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: whiteColor),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: defaultAppBlueColor.withOpacity(0.5),
                        child: Container(
                          margin: EdgeInsets.all(3.0),
                          child: TextFormField(
                            controller: _controllerPass,
                            style: TextStyle(
                                color: whiteColor, fontWeight: FontWeight.bold),
                            validator: (v) => Validator.commonValidation(
                                v, "Password can't be empty"),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              hintText: "Your Password",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: whiteColor,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                // child: new Text(_obscureText ? "Show" : "Hide"),
                                icon: _obscureText
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Colors.white,
                                      ),
                              ),
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: whiteColor),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Center(
                        child: _loaderState
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    height: 30.0,
                                    width: 30.0,
                                    child: ProgressIndicatorWidget()),
                              )
                            : Container(
                                height: 45.0,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 3.0),
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    color: defaultAppBlueColor,
                                    child: Text("LOG IN"),
                                    textColor: whiteColor,
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        setLoaderState(true);

                                        var response =
                                            await _netWorkAPiRepository
                                                .loginUserUsingRepo(
                                                    _controllerName.text,
                                                    _controllerPass.text);

                                        if (response is String) {
                                          var tokenSaved = await userTokendata
                                              .setUserToken(response);
                                          if (!tokenSaved) {
                                            setLoaderState(false);
                                            buildErrorDialog(context,
                                                "Error occured While login");
                                          }
                                        } else {
                                          setLoaderState(false);
                                          buildErrorDialog(
                                              context, "Login Failed");
                                        }
                                      }
                                    }),
                              ),
                      ),
                      SizedBox(height: 10.0),
                      FlatButton(
                          onPressed: () {
                            //

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ForgotPassword()));
                          },
                          child: Text(
                            "forgot password?",
                            style: TextStyle(color: whiteColor),
                          )),
                      FlatButton(
                          onPressed: () {
                            try {
                              FlutterOpenWhatsapp.sendSingleMessage(
                                  "916255220961",
                                  "Hi, I need help in using your App");
                            } catch (e) {
                              print(e.toString());
                            }
                          },
                          child: Text(
                            "Contact customer support",
                            style: TextStyle(color: whiteColor),
                          )),
                      // RaisedButton(
                      //   onPressed: () {
                      //     couter(Map<String, dynamic> message) {
                      //       int countr;
                      //       if (message != 0) {
                      //         countr++;
                      //       }
                      //     }
                      //   },
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  setLoaderState(bool newstate) {
    setState(() {
      _loaderState = newstate;
    });
  }
}
