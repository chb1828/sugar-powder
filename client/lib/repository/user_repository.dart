import 'dart:convert';

import 'package:sugar_client/dto/user/user_common_dto.dart';
import 'package:http/http.dart' as http;
import 'package:sugar_client/dto/user/user_dto.dart';

class UserRepository {
  Future<UserDTO> createUser(UserCommonDTO dto) async {
    final http.Response response = await http.post(
      'http://52.78.172.230:8080/api/user',
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        "Charset": 'utf-8',
      },
      body: jsonEncode(<String, dynamic>{
        'deviceToken': dto.deviceToken,
        'notiYn': dto.notiYn,
        'nickname': "string",
        'token': dto.loginId
      }),
    );
    if (response.statusCode == 200) {
      print("성공");
      final decodeData = utf8.decode(response.bodyBytes);
      Map<String, dynamic> map = jsonDecode(decodeData);
      print(map);
      return UserDTO.fromJson(map);
    } else {
      throw Exception("실패");
    }
  }

  Future<UserDTO> getUser(String loginId) async {
    print("로그인 아이디 :$loginId");
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": loginId
    };
    var body = {'token': loginId};
    var uri = Uri.http('52.78.172.230:8080', '/api/user', body);
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final decodeData = utf8.decode(response.bodyBytes);
      Map<String, dynamic> map = jsonDecode(decodeData);
      print(map);
      return UserDTO.fromJson(map['data']);
    } else if (response.statusCode == 400) {
      print("유저가 존재하지 않음");
      return null;
    } else {
      throw Exception("유저 정보 가져오기 실패");
    }
  }

  Future<bool> updateNickname(UserCommonDTO dto, String nickname) async {
    print("수정될 아이디 ${dto.loginId}");

    final http.Response response = await http.put(
      'http://52.78.172.230:8080/api/user',
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        "Charset": 'utf-8',
        "Authorization": dto.loginId
      },
      body: jsonEncode(<String, dynamic>{
        "deviceToken": dto.deviceToken,
        'nickname': nickname,
        'token': dto.loginId,
      }),
    );

    if (response.statusCode == 200) {
      print("user 수정 성공");
      return Future.value(true);
    } else {
      throw Exception("유저 수정 실패");
    }
  }

  Future<bool> updateNoti(UserCommonDTO dto) async {
    final baseUrl = "http://52.78.172.230:8080/";
    final url = Uri.parse(baseUrl + "api/user");
    final request = http.Request("PUT", url);
    request.headers.addAll(<String, String>{
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": dto.loginId
    });
    request.body = jsonEncode({
      "deviceToken": dto.deviceToken,
      "nickname": dto.nickname,
      "token": dto.loginId,
      "notiYn": dto.notiYn
    });
    final response = await request.send();
    if (response.statusCode == 200) {
      print("수정된 알림 ${dto.notiYn}");
      return Future.value(dto.notiYn);
    } else {
      throw Exception("유저 수정 실패");
    }
  }

  Future<bool> removeUser(String loginId) async {
    print("삭제될 아이디 $loginId");

    final baseUrl = "http://52.78.172.230:8080/";
    final url = Uri.parse(baseUrl + "api/user");
    final request = http.Request("DELETE", url);
    request.headers.addAll(<String, String>{
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": loginId
    });
    request.body = jsonEncode({"token": loginId});
    final response = await request.send();
    if (response.statusCode == 200) {
      print("user 삭제 성공");
      return true;
    } else {
      throw Exception("유저 삭제 실패");
    }
  }
}
