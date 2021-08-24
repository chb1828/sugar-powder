import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/user.dart';
import 'package:sugar_client/service/storage_service.dart';
import 'package:sugar_client/service/dday_service.dart';
import 'package:sugar_client/service/user_service.dart';

class KakaoLoginTest extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KakaoLogin();
  }
}

class KakaoLogin extends StatefulWidget {
  KakaoLogin({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _KakaoLoginState createState() => _KakaoLoginState();
}

class _KakaoLoginState extends State<KakaoLogin> {

  bool _isKakaoTalkInstalled = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initKakaoTalkInstalled();
  }

  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    print('kakao Install : ' + installed.toString());

    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  loginWithTalk() async {
    try {
      var code = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      String id = await UserService().getSocialUserId(); // 소셜 id 값
      StorageService().saveLoginId(id); //소셜 id 값 저장
      
      if (!await UserService().getUser()) {
        UserService().createUser(); //유저 등록
      }

      Get.offAllNamed("/home");
      // Get.offAllNamed("/today",arguments: "CREATE");
    } catch (e) {
      print("error on issuing access token: $e");
    }
  }

  loginWithKakao() async {
    try {
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    isKakaoTalkInstalled();

    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 52,
      child: RaisedButton(
          color: Color.fromRGBO(255, 232, 19, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
              color: Color.fromRGBO(255, 232, 19, 1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/iconKakao.png",
                width: 24,
                height: 24,
              ),
              Text(
                "카카오톡으로 로그인하기",
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
          onPressed: _isKakaoTalkInstalled ? loginWithTalk : loginWithKakao),
    );
  }
}

class LoginDone extends StatelessWidget {
  Future<bool> _getUser() async {
    try {
      User user = await UserApi.instance.me();
      print(user.toString());
    } on KakaoAuthException catch (e) {} catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    _getUser();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Login Success!'),
        ),
      ),
    );
  }
}
