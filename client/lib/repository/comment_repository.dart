
import 'dart:convert';

import 'package:sugar_client/dto/comment/comment_common_dto.dart';
import 'package:http/http.dart' as http;
import 'package:sugar_client/dto/comment/comment_dto.dart';

class CommentRepository {
  Future<bool> createComment(CommentCommonDTO comment, loginId) async {

    print("passed comment: ${comment.comment}");
    print(comment.ddayId);
    print(comment.token);

    final http.Response response = await http.post(
      'http://52.78.172.230:8080/api/comments',
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        "Charset": 'utf-8',
        "Authorization" : loginId
      },
      body: jsonEncode(<String, dynamic> {
        'comment': comment.comment,
        'ddayId': comment.ddayId,
        'userToken': comment.token,
      }),
    );
    if(response.statusCode == 200) {
      print("코멘트 전송완료");
      print(response.body);
      return Future.value(true);
    }else {
      throw Exception("Failed to load album");
    }
  }

  Future<bool> reportComment(String commentId,String loginId) async {

    final http.Response response = await http.post(
        'http://52.78.172.230:8080/api/report/comment/$commentId',
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          "Charset": 'utf-8',
          "Authorization" : loginId
        }
    );
    if(response.statusCode == 200) {
      print(response.body);
      return Future.value(true);
    }else {
      return Future.value(false);
    }
  }

  Future<List<CommentDTO>> getCommentList(int pageNumber,int limit, int dDayId, String loginId) async {
    List<CommentDTO> _commentList = new List<CommentDTO>();
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": loginId
    };

    var body = {'size': "$limit",'page':"$pageNumber", 'ddayId': "$dDayId"};
    var uri = Uri.http('52.78.172.230:8080', "/api/comments/${dDayId}", body);
    var response = await http.get(uri, headers: headers);
    print("dDayId: ${dDayId}");
    print("limit: ${limit}");
    print("pageNumber: ${pageNumber}");
    final decodeData = utf8.decode(response.bodyBytes);
    Map<String, dynamic> map = jsonDecode(decodeData);
    
    try{
      List<dynamic> values = map["data"]["commentList"];
      print(values);

      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          Map<String, dynamic> map = values[i];
          _commentList.add(CommentDTO.fromJson(map));
        }
      }
      return _commentList;
    }catch(e){
     print(e);
     return []; 
    }
  }

  Future<bool> deleteComment(String commentId,String loginId) async {
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Charset": 'utf-8',
      "Authorization": loginId
    };

    var uri = Uri.http('52.78.172.230:8080', '/api/comments/$commentId');
    var response = await http.delete(uri, headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("실패");
    }
  }

}