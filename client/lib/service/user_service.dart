import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/user.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sugar_client/dto/user/user_common_dto.dart';
import 'package:sugar_client/dto/user/user_dto.dart';
import 'package:sugar_client/repository/user_repository.dart';
import 'package:sugar_client/service/storage_service.dart';

class UserService {

  final storage = FlutterSecureStorage();

  void createUser() async {

    String deviceToken = await StorageService().getDeviceToken();
    String loginId =  await StorageService().getLoginId();
    bool notiYn = await Permission.notification.isGranted;

    UserCommonDTO dto = UserCommonDTO(loginId: loginId,deviceToken: deviceToken,notiYn: notiYn);

    UserRepository().createUser(dto);
  }

  Future<bool> getUser() async {
    String loginId = await StorageService().getLoginId();
    UserDTO dto = await UserRepository().getUser(loginId);

    if(dto !=null) {
      // 필요한 정보를 스토리지에 저장한다.
      StorageService().saveDeviceToken(dto.deviceToken);
      StorageService().saveLoginId(loginId);
      StorageService().saveNickname(dto.nickname);
      StorageService().saveUserNoti(dto.notiYn == true ? true : false);

      return Future.value(true);
    }
    return Future.value(false);
  }


  updateNickname(String nickname) async {
    String loginId = await StorageService().getLoginId();
    String deviceToken = await StorageService().getDeviceToken();
    UserCommonDTO dto = UserCommonDTO(loginId: loginId,deviceToken: deviceToken);

    UserRepository().updateNickname(dto,nickname);

    StorageService().saveNickname(nickname);
    print("user 수정 성공");

  }

  updateNoti(bool noti) async {
    String loginId = await StorageService().getLoginId();
    String deviceToken = await StorageService().getDeviceToken();
    String nickname = await StorageService().getNickname();

    UserCommonDTO dto = UserCommonDTO(loginId: loginId,deviceToken: deviceToken,notiYn: noti,nickname: nickname);
    bool afterNoti = await UserRepository().updateNoti(dto);
    StorageService().saveUserNoti(afterNoti);
    return afterNoti;
  }

  deleteUser() async {
    String loginId = await StorageService().getLoginId();
    return UserRepository().removeUser(loginId);

  }

  getSocialUserId() async {
    try {
      User user = await UserApi.instance.me();
      if (user!=null) {
        String userId = user.id.toString();
        return userId;
      }
      return null;
      // do anything you want with user instance
    } on KakaoAuthException catch (e) {
      print(e.error);
      print(e.errorDescription);
    } catch (e) {
      // other api or client-side errors
      print(e.toString());
    }
  }

}
