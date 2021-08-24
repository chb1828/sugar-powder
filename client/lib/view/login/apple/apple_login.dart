import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sugar_client/service/storage_service.dart';
import 'package:sugar_client/service/dday_service.dart';
import 'package:sugar_client/service/user_service.dart';

class AppleLogin extends StatefulWidget {
  AppleLogin({Key key}) : super(key: key);

  @override
  _AppleLoginState createState() => _AppleLoginState();
}

class _AppleLoginState extends State<AppleLogin> {

  @override
  Widget build(BuildContext context) {
    return SignInWithAppleButton(
      height: 52,
      text: "Apple로 로그인", 
      style: SignInWithAppleButtonStyle.white,
      
      onPressed: () async {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        StorageService().saveLoginId(credential.userIdentifier); //소셜 id 값 저장
        if (!await UserService().getUser()) {
          UserService().createUser(); //유저 등록
        }
        Get.offAllNamed("/home");
        // Get.toNamed("/today",arguments: "CREATE");

        // print(credential.identityToken);

        // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
        // after they have been validated with Apple (see `Integration` section for more information on how to do this)
      },
    );
  }
}
