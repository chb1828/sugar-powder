import 'package:sugar_client/dto/dday/dday_list_dto.dart';
import 'package:sugar_client/repository/month_repository.dart';
import 'package:sugar_client/service/storage_service.dart';

class MonthService {

  Future<List<DDayListDTO>> getRecommendTag(String month) async {
    String loginId = await StorageService().getLoginId();
    return MonthRepository().getDdaysByMonth(month, loginId);
  }

}