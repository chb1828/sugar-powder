import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:sugar_client/service/user_service.dart';

class StorageService {
  final storage = FlutterSecureStorage();

  //저장소에 토큰 저장
  saveLoginId(String id) async {
    await storage.write(key: "social_login_id", value: id);
  }

  saveDeviceToken(String token) async {
    await storage.write(key: "device_token", value: token);
  }

  saveNickname(String nickname) async {
    await storage.write(key: "nickname", value: nickname);
  }

  Future<bool> saveUserNoti(bool noti) async {
    await storage.write(key: "noti", value: "$noti");
    return true;
  }

  //토큰 가져오기
  getLoginId() async {
    String loginId = await storage.read(key: "social_login_id");
    return loginId;
  }

  getDeviceToken() async {
    String token = await storage.read(key: "device_token");
    return token;
  }

  getNickname() async {
    String nickname = await storage.read(key: "nickname");
    return nickname;
  }

  Future<bool> getUserNoti() async {
    String notiData = await storage.read(key: "noti");
    bool noti = notiData.toLowerCase() == 'true';
    return noti;
  }

  //로그아웃
  logout() async {
    try {
      await storage.delete(key: "social_login_id");
      var code = await UserApi.instance.logout();
      await AccessTokenStore.instance.clear();
      print(code.toString());
    } catch (e) {
      print(e);
    }
  }

  //탈퇴하기
  withdraw() async {
    try {
      UserService().deleteUser();
      await storage.delete(key: "social_login_id");
      var code = await UserApi.instance.unlink();
      await AccessTokenStore.instance.clear();
      print(code.toString());
    } catch (e) {
      print(e);
    }
  }

}
