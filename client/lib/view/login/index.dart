import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sugar_client/constant/constant.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/user.dart';
import 'package:sugar_client/view/login/apple/apple_login.dart';

import 'kakao/kakao_login.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    KakaoContext.clientId = '2b66f4272fdfa9c6b0c7d34ea4b30a10';
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(width / 2);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Color.fromRGBO(17, 17, 17, 1.0),
            appBar: new AppBar(
              centerTitle: false,
              title: Transform(
                // you can forcefully translate values left side using Transform
                transform: Matrix4.translationValues(width * .65, 0.0, 0.0),
              ),
              backgroundColor: Color.fromRGBO(17, 17, 17, 1.0),
              elevation: 0.0,
            ),
            body: Transform(
              transform: Matrix4.translationValues(0.0, height / 7, 0.0),
              child: Scaffold(
                backgroundColor: Color.fromRGBO(17, 17, 17, 1.0),
                body: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: fixPadding * 1),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Image.asset(
                              "assets/bitmap.png",
                              width: 218,
                              height: 168,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: fixPadding * 1),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              '디데이까지 함께하는 여정',
                              style: TextStyle(color: Colors.white, fontSize: 24),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                    Container(height: height / 12),
                    Padding(
                      padding: EdgeInsets.only(
                          top: fixPadding * 2,
                          right: fixPadding * 2,
                          left: fixPadding * 2),
                      child: SizedBox(
                        height: 120.0,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.transparent),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                KakaoLogin(),
                                Divider(height: 16),
                                Platform.isIOS ? AppleLogin() : Container()
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // return MaterialApp(
    //   home: KakaoLogin(),
    // );
  }
}
