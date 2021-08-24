import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:sugar_client/provider/comment_infinite_provider.dart';
import 'package:sugar_client/provider/dday_infinite_provider.dart';
import 'package:sugar_client/provider/month_provider.dart';
import 'package:sugar_client/provider/notification_provider.dart';
import 'package:sugar_client/router/app_pages.dart';
import 'package:sugar_client/service/firebase_messaging_service.dart';
import 'package:sugar_client/service/permission_service.dart';
import 'package:sugar_client/service/firebase_share_service.dart';
import 'package:sugar_client/view/create/colorProvider.dart';
import 'package:sugar_client/view/splash/index.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => ColorProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => MonthProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => DDayInfiniteProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CommentInfiniteProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => NotificationProvider(),
      )
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      title: 'Sugar Client',
      theme: ThemeData(),
      home: HomePage(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    ShareService().initDynamicLinks(context);
    FirebaseMessagingService().pushMessageInitilaise();
    PermissionService().setPermission();
  }

  Future<ConnectivityResult> checkConnectionStatus() async {
    var result = await (Connectivity().checkConnectivity());
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkConnectionStatus(), // async work
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Text('Error: ${snapshot.error}');
          else {
            final status = snapshot.data;
            if (status == ConnectivityResult.none) {
              Future(() {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) => Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          //this right here
                          child: Container(
                            height: 300.0,
                            width: 300.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    '인터넷을 연결해야 합니다.',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 50.0)),
                                FlatButton(
                                    onPressed: () {
                                      if (Platform.isAndroid) {
                                        SystemNavigator.pop();
                                      } else if (Platform.isIOS) {
                                        exit(
                                            0); // 권장하지 않는 방법이라.... apple 에서 막을수도있음
                                      }
                                    },
                                    child: Text(
                                      '확인!',
                                      style: TextStyle(
                                          color: Colors.purple, fontSize: 18.0),
                                    ))
                              ],
                            ),
                          ),
                        ));
              });
              return Container();
            }
            return SplashScreen();
          }
        });

    //SplashScreen();
  }
}
