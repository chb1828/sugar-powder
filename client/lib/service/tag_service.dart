import 'package:sugar_client/repository/tag_repository.dart';
import 'package:sugar_client/service/storage_service.dart';

class TagService {

  Future<List<dynamic>> getRecommendTag() async {
    String loginId = await StorageService().getLoginId();

    return TagRepository().getRecommendTag(loginId);
   
  }

}