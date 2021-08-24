import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sugar_client/dto/dday/dday_list_dto.dart';

class MonthRepository {

  Future<List<DDayListDTO>> getDdaysByMonth(String month,String loginId) async {

    List<DDayListDTO> _dDayList = new List<DDayListDTO>();

    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": loginId
    };

    var body = {'month': month};
    var uri = Uri.http('52.78.172.230:8080', '/api/search/month', body);
    var response = await http.get(uri, headers: headers);

    if (response.bodyBytes.isNotEmpty) {
      final decodeData = utf8.decode(response.bodyBytes);
      var values = jsonDecode(decodeData);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            _dDayList.add(DDayListDTO.fromJson(map));

          }
        }
      }
      return _dDayList;
    }else {
      throw Exception("에러");
    }
  }

}