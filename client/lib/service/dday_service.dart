import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sugar_client/dto/dday/dday_common_dto.dart';
import 'package:sugar_client/dto/dday/dday_dto.dart';
import 'package:sugar_client/dto/dday/dday_list_dto.dart';
import 'package:sugar_client/dto/dday/dday_list_dto_param.dart';
import 'package:sugar_client/dto/dday/dday_search_dto.dart';
import 'package:sugar_client/repository/dday_repository.dart';
import 'package:sugar_client/service/storage_service.dart';
import 'package:sugar_client/util/converter.dart';

class DDayPostService {

  Future<DDayDTO> createDDay(DDayDTO dday) async {
    String _date = Converter().convertToDate(dday.date, dday.time);
    dday.date = _date;
    return await DDayRepository().createDDay(dday);
  }

  Future<DDayDTO> updateDDay(DDayDTO dday) async {
    String _date = Converter().convertToDate(dday.date, dday.time);
    dday.date = _date;
    return DDayRepository().updateDDay(dday);
  }

  Future<List<DDayListDTO>> getDdays(int pageNumber, int limit, String ddaySortType, bool includePastDate) async {

    String loginId = await StorageService().getLoginId();

    String dDaySortTypeStringData;
    if(ddaySortType == "팔로우순"){
      dDaySortTypeStringData = "FOLLOW_COUNT";
    }else if(ddaySortType == "생성일순"){
      dDaySortTypeStringData = "CREATE";
    }else if(ddaySortType == "가까운순"){
      dDaySortTypeStringData = "NEAREST";
    }

    DDayListDTOParam dto = DDayListDTOParam(page: pageNumber,limit: limit, sort: dDaySortTypeStringData,loginId: loginId, isIncludeEnd: includePastDate);
    return await DDayRepository().getDDayList(dto);
  }

  Future<DDayListDTO> getOneDday(dDayId) async {
    String loginId = await StorageService().getLoginId(); //필요
    DDayCommonDTO dto = DDayCommonDTO(ddayId: dDayId, loginId: loginId);
    return await DDayRepository().getOneDDay(dto);
  }

  Future<bool> removeDday(dDayId) async {
    String loginId = await StorageService().getLoginId(); //필요
    DDayCommonDTO dto = DDayCommonDTO(ddayId: dDayId, loginId: loginId);
    return await DDayRepository().removeDday(dto);
  }

  Future<List<DDayListDTO>> getSearchDdays(String text, int pageNumber, int limit) async {
    String loginId = await StorageService().getLoginId();
    DDaySearchDTO dto = DDaySearchDTO(page: pageNumber,loginId: loginId,limit: limit,text: text);
    return await DDayRepository().getSearchDDays(dto);
  }

  Future<List<DDayListDTO>> getTodayTopDDays() async {
    String loginId = await StorageService().getLoginId();
    return await DDayRepository().getTodayPageTopDDays(loginId);
  }

  Future<List<DDayListDTO>> getPopularDday() async {
    String loginId = await StorageService().getLoginId();
    return await DDayRepository().getPopularDDays(loginId);
  }

  //Check if the current user follows the dday
  Future<bool> checkifFollowedDday(int dDayId) async {
    String loginId = await StorageService().getLoginId();
    DDayCommonDTO dto = DDayCommonDTO(ddayId: dDayId, loginId: loginId);
    return await DDayRepository().checkifFollowedDday(dto);
  }

  Future<bool> followDday(int dDayId) async {
     String loginId = await StorageService().getLoginId();
     DDayCommonDTO dto = DDayCommonDTO(ddayId: dDayId, loginId: loginId);
     return await DDayRepository().followDDay(dto);
  }

  Future<bool> unfollowDday(int dDayId) async {
    String loginId = await StorageService().getLoginId();
    DDayCommonDTO dto = DDayCommonDTO(ddayId: dDayId, loginId: loginId);
    return await DDayRepository().unfollowDDay(dto);
  }

  Future<bool> reportDday(int dDayId) async {
     String loginId = await StorageService().getLoginId();
     DDayCommonDTO dto = DDayCommonDTO(ddayId: dDayId, loginId: loginId);
     return await DDayRepository().reportDDay(dto);
  }

  Future<bool> manageNotification(int dDayId, bool status) async {
    String loginId = await StorageService().getLoginId();
    DDayCommonDTO dto = DDayCommonDTO(ddayId: dDayId, loginId: loginId);
    return await DDayRepository().manageNotification(dto, status);
  }


}