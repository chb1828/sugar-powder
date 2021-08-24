import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar_client/service/storage_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String getBrandImage;

  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 2),
      () async {
        String token = await StorageService().getLoginId();
        print(token);
        if(token==null) {
          Get.offAllNamed("/login");
        }else {
          Get.offAllNamed("/home");
          // Get.offAllNamed("/today",arguments: "CREATE");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/splash/splash@2x.png'), fit: BoxFit.contain),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              width: width,
              height: height,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
