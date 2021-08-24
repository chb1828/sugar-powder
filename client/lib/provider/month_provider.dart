import 'package:flutter/material.dart';
import 'package:sugar_client/dto/dday/dday_list_dto.dart';
import 'package:sugar_client/service/month_service.dart';

class MonthProvider extends ChangeNotifier{
  Future<List<DDayListDTO>> cache;

  //로딩
  bool loading = false;

  Future<List<DDayListDTO>> _makeRequest({@required String month}) async {
    assert(month !=null);

    return MonthService().getRecommendTag(month);
  }

  fetchItem({
    String month,
  }) async {
    month ??= "1";

    loading = true;

    notifyListeners();

    this.cache = _makeRequest(month: month);

    loading = false;

    notifyListeners();

  }
}