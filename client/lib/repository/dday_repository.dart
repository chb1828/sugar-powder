import 'dart:convert';
import 'package:http/http.dart';
import 'package:sugar_client/dto/dday/dday_common_dto.dart';
import 'package:sugar_client/dto/dday/dday_dto.dart';
import 'package:sugar_client/dto/dday/dday_list_dto.dart';
import 'package:sugar_client/dto/dday/dday_list_dto_param.dart';
import 'package:sugar_client/dto/dday/dday_search_dto.dart';
import 'package:sugar_client/service/storage_service.dart';
import 'package:http/http.dart' as http;

class DDayRepository {

  Future<DDayDTO> createDDay(DDayDTO dday) async {

    String loginId = await StorageService().getLoginId();
    final http.Response response = await http.post(
      'http://52.78.172.230:8080/api/dday',
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        "Charset": 'utf-8',
        "Authorization": loginId
      },
      body: jsonEncode(<String, dynamic>{
        'title': dday.title,
        'color': dday.color,
        'date': dday.date,
        'ddayType': dday.ddayType,
        'emoji': dday.emoji,
        'place': dday.place,
        'tags': dday.tags,
        'token': dday.token,
        'description': dday.description
      }),
    );
    if (response.statusCode == 200) {
      print("생성 성공");
      final decodeData = utf8.decode(response.bodyBytes);
      Map<String,dynamic> map= jsonDecode(decodeData);
      return DDayDTO.fromJson(map["data"]); // 디테일 페이지 이동을 위해서 dday를 리턴해줘야함
    } else {
      throw Exception("Failed to load album");
    }
  }

  Future<DDayDTO> updateDDay(DDayDTO dday) async {

    String loginId = await StorageService().getLoginId();
    final http.Response response = await http.put(
      'http://52.78.172.230:8080/api/dday/${dday.id}',
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        "Charset": 'utf-8',
        "Authorization": loginId
      },
      body: jsonEncode(<String, dynamic>{
        "id": dday.id,
        'title': dday.title,
        'color': dday.color,
        'date': dday.date,
        'ddayType': dday.ddayType,
        'emoji': dday.emoji,
        'place': dday.place,
        'tags': dday.tags,
        'description': dday.description
      }),
    );
    if (response.statusCode == 200) {
      print("수정 성공");
      final decodeData = utf8.decode(response.bodyBytes);
      Map<String,dynamic> map= jsonDecode(decodeData);
      return DDayDTO.fromJson(map["data"]);
    } else {
      print(response.body);
      throw Exception("Failed to load album");
    }
  }

  Future<List<DDayListDTO>> getDDayList(DDayListDTOParam dto) async {

    List<DDayListDTO> _dDayList = new List<DDayListDTO>();
    
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": dto.loginId
    };

    print(dto.isIncludeEnd);
    var body = {
      'isIncludeEnd': "${dto.isIncludeEnd}",
      'size': "${dto.limit}",
      'page': "${dto.page}",
      'daySort': "${dto.sort}"
    };

    var uri = Uri.http('52.78.172.230:8080', '/api/dday', body);
    var response = await http.get(uri, headers: headers);
    final decodeData = utf8.decode(response.bodyBytes);
    Map<String, dynamic> map = jsonDecode(decodeData);

    print("PASSED VALUE:::");
    print(dto.sort);

    List<dynamic> values = map["data"]["ddayList"];
    print(values);

    if (values.length > 0) {
      for (int i = 0; i < values.length; i++) {
        Map<String, dynamic> map = values[i];
        _dDayList.add(DDayListDTO.fromJson(map));
      }
    }

    return _dDayList;
  }

  Future<DDayListDTO> getOneDDay(DDayCommonDTO dto) async {
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": dto.loginId
    };

    var uri = Uri.http('52.78.172.230:8080', '/api/dday/${dto.ddayId}');
    var response = await http.get(uri, headers: headers);

    final decodeData = utf8.decode(response.bodyBytes);
    Map<String, dynamic> map = json.decode(decodeData);
    var dday = DDayListDTO.fromJson(map['data']);
    return dday;
  }

  Future<bool> removeDday(DDayCommonDTO dto) async {
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": dto.loginId
    };

    var uri = Uri.http('52.78.172.230:8080', '/api/dday/${dto.ddayId}');
    var response = await http.delete(uri, headers: headers);

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      throw Exception("실패");
    }
  }

  Future<List<DDayListDTO>> getSearchDDays(DDaySearchDTO dto) async {
    List<DDayListDTO> _dDayList = new List<DDayListDTO>();
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": dto.loginId
    };
    var body = {"page": "${dto.page}", "query": "${dto.text}", "size": "${dto.limit}"};
    var uri = Uri.http('52.78.172.230:8080', '/api/search', body);
    Response response = await get(uri, headers: headers);
    final decodeData = utf8.decode(response.bodyBytes);
    List<dynamic> values = jsonDecode(decodeData);
    //print(values);

    if (values.length > 0) {
      for (int i = 0; i < values.length; i++) {
        Map<String, dynamic> map = values[i];
        _dDayList.add(DDayListDTO.fromJson(map));
      }
    }
    return _dDayList;
  }

  Future<List<DDayListDTO>> getTodayPageTopDDays(String loginId) async {
    List<DDayListDTO> _dDayList = new List<DDayListDTO>();

    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": loginId
    };
    // var body = {"page":"$pageNumber","query":text,"size":"$limit"};
    var uri = Uri.http('52.78.172.230:8080', '/api/search/today');
    Response response = await get(uri, headers: headers);

    final decodeData = utf8.decode(response.bodyBytes);
    try {
      List<dynamic> values = jsonDecode(decodeData);
    //print(values);
    if (values.length > 0) {
      for (int i = 0; i < values.length; i++) {
        Map<String, dynamic> map = values[i];
          _dDayList.add(DDayListDTO.fromJson(map));
        }
      }
      return _dDayList;

    }catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<DDayListDTO>> getPopularDDays(String loginId) async {
    List<DDayListDTO> _dDayList = new List<DDayListDTO>();
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": loginId
    };
    // var body = {"page":"$pageNumber","query":text,"size":"$limit"};
    var uri = Uri.http('52.78.172.230:8080', '/api/search/dday/popular');
    Response response = await get(uri, headers: headers);

    final decodeData = utf8.decode(response.bodyBytes);
    try{
      List<dynamic> values = jsonDecode(decodeData);
      //print(values);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          Map<String, dynamic> map = values[i];
          _dDayList.add(DDayListDTO.fromJson(map));
        }
      }
      return _dDayList;
    }catch(e){
      print(e);
      return [];
    }
  }

  //Check if the current user follows the dday
  Future<bool> checkifFollowedDday(DDayCommonDTO dto) async {
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": dto.loginId
    };

    var uri = Uri.http('52.78.172.230:8080', '/api/dday/${dto.ddayId}/follow');
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      if(response.body == "true"){
        return Future.value(true);
      }else{
        return Future.value(false);
      }
    } else {
      //return false;
      throw Exception("실패");
    }
  }

  Future<bool> followDDay(DDayCommonDTO dto) async {
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": dto.loginId
    };
    var uri = Uri.http('52.78.172.230:8080', '/api/dday/${dto.ddayId}/follow');
    var response = await http.post(uri, headers: headers);
    if (response.statusCode == 200) {
      return Future.value(true);
    }else {
      throw Exception("실패");
    }
  }

  Future<bool> unfollowDDay(DDayCommonDTO dto) async {
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": dto.loginId
    };

    var uri = Uri.http('52.78.172.230:8080', '/api/dday/${dto.ddayId}/unfollow');
    var response = await http.post(uri, headers: headers);
    if (response.statusCode == 200) {
      return true;
    }else {
      print(dto.ddayId);
      //return false;
      throw Exception("실패");
    }
  }

  Future<bool> reportDDay(DDayCommonDTO dto) async {
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": dto.loginId
    };

    var uri = Uri.http('52.78.172.230:8080', '/api/report/dday/${dto.ddayId}');
    var response = await http.post(uri, headers: headers);
    if (response.statusCode == 200) {
      return true;
    }else {
      //return false;
      throw Exception("실패");
    }
  }

   Future<bool> manageNotification(DDayCommonDTO dto, bool status) async {
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": dto.loginId
    };
    var body = {
      'ddayId': "${dto.ddayId}",
      'notiYn': "${status}"
    };

    var uri = Uri.http('52.78.172.230:8080', '/api/dday/${dto.ddayId}', body);
    var response = await http.post(uri, headers: headers);

    if (response.statusCode == 200) {
      return true;
    }else {
      //return false;
      throw Exception("실패");
    }
  }
  


}