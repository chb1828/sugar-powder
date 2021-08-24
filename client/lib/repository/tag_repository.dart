import 'dart:convert';
import 'package:http/http.dart' as http;

class TagRepository {

  Future<List<dynamic>> getRecommendTag(String loginId) async {

    // print(loginId);
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": loginId
    };

    var uri = Uri.http('52.78.172.230:8080', '/api/search/tag/popular');
    var response = await http.get(uri, headers: headers);

    final decodeData = utf8.decode(response.bodyBytes);
    if(response.statusCode == 200){
      List<dynamic> tags = jsonDecode(decodeData);
      print(tags);
      return tags;
    }else{
      return [];
    }

  }
}