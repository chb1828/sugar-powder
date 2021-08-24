import 'package:flutter/material.dart';
import 'package:sugar_client/dto/dday/dday_list_dto.dart';
import 'package:sugar_client/service/dday_service.dart';

class DDayInfiniteProvider extends ChangeNotifier{

  final int _limit = 7;
  int _currentPage = 0;
  String _sort;
  
  String defaultFilterValue = "생성일순";
  bool includePastDate = false;

  List<DDayListDTO> cache;

  // 로딩
  bool loading = false;
  // 아이템이 더 있는지
  bool hasMore = true;

  Future<List<DDayListDTO>> _makeRequest({
    @required int nextPage,@required String sort
  }) async {
    assert(nextPage != null && sort != null);

    return DDayPostService().getDdays(nextPage, _limit, sort, includePastDate);
  }

  fetchItems({
    String sort
  }) async {

    sort !=null ? _sort = sort : _sort = "생성일순";

    loading = true;

    notifyListeners();

    final items = await _makeRequest(nextPage: _currentPage,sort: _sort);
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

  toggleIncludePastDate() async {
    includePastDate = !includePastDate;
    notifyListeners();
  }

  bool getIncludePastDate() {
    return includePastDate;
  }

  updateFilterValue(String value){
    defaultFilterValue = value;
  }

  String getDefaultFilterValue(){
    return defaultFilterValue;
  }
}