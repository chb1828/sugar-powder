import 'package:get/get.dart';
import 'package:sugar_client/dto/comment/comment_common_dto.dart';
import 'package:sugar_client/dto/comment/comment_dto.dart';
import 'package:sugar_client/repository/comment_repository.dart';
import 'package:sugar_client/service/storage_service.dart';

class CommentService {

  Future<bool> createComment(CommentCommonDTO comment) async {
    String loginId = await StorageService().getLoginId();
    return CommentRepository().createComment(comment, loginId);
  }

  Future reportComment(String commentId) async {
    String loginId = await StorageService().getLoginId();
    return CommentRepository().reportComment(commentId, loginId);
  }

  Future<List<CommentDTO>> getCommentList(
      int pageNumber, int limit, int dDayId) async {
    String loginId = await StorageService().getLoginId();
    return CommentRepository()
        .getCommentList(pageNumber, limit, dDayId, loginId);
  }

  Future<bool> deleteComment(String commentId) async {
    String loginId = await StorageService().getLoginId(); //필요
    return CommentRepository().deleteComment(commentId,loginId);
  }
}
