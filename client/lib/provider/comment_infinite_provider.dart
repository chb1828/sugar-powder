import 'package:flutter/material.dart';
import 'package:sugar_client/dto/comment/comment_dto.dart';
import 'package:sugar_client/dto/dday/dday_list_dto.dart';
import 'package:sugar_client/service/comment_service.dart';
import 'package:sugar_client/service/dday_service.dart';
import 'package:sugar_client/service/month_service.dart';

class CommentInfiniteProvider extends ChangeNotifier{

  final int _limit = 7;
  int _currentPage = 0;

  List<CommentDTO> cache;

  // 로딩
  bool loading = false;
  // 아이템이 더 있는지
  bool hasMore = true;

  Future<List<CommentDTO>> _makeRequest({
    @required int nextPage,@required int ddayId
  }) async {
    assert(nextPage != null && ddayId != null);

    return  CommentService().getCommentList(nextPage,_limit,ddayId);
  }

  fetchItems({
    int ddayId
  }) async {

    loading = true;

    notifyListeners();

    final items = await _makeRequest(nextPage: _currentPage, ddayId: ddayId);
    print("$_currentPage 요청!!");
    _currentPage++;

    this.cache = [
      ...?this.cache,
      ...items,
    ];

    if(items.length == 0){
      hasMore = false;
    }

    loading = false;

    notifyListeners();
  }

  init() {
    _currentPage = 0;
    hasMore = true;
    cache = [];
  }
}