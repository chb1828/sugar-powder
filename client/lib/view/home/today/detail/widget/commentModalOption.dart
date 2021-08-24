import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sugar_client/provider/comment_infinite_provider.dart';
import 'package:sugar_client/service/comment_service.dart';

class BottomPopup {

  int commentId;
  String userName;
  bool owner;
  int dDayId;
  BottomPopup({this.userName});

  mainBottomSheet(BuildContext context,
      {String userName, int commentId, bool owner, int dDayId}) {
    // print(userName);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          print("ddayId is: ${dDayId}");
          print("commentId is: ${commentId}");
          if (owner == true) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _createTile(
                    context, '삭제하기', userName, _action3, commentId, "action3", dDayId),
                _createTile(context, '닫기', "", _action2, commentId, "action2", dDayId),
              ],
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _createTile(
                    context, '신고하기', userName, _action1, commentId, "action1", dDayId),
                _createTile(context, '닫기', "", _action2, commentId, "action2", dDayId),
              ],
            );
          }
        });
  }

  Widget _createTile(BuildContext context, String name, String userName,
      Function action, int commentId, String whichAction, int dDayId) {
    return InkWell(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text(name),
          ),
        ),
      ),
      onTap: () async {
        if (whichAction == "action1") {
          var result = await CommentService().reportComment("$commentId");
          action(userName, result);
          Get.back();
        } else if (whichAction == "action3") {
          var result = await CommentService().deleteComment("$commentId");
          action(userName, result);
          Future.microtask(() {
            Provider.of<CommentInfiniteProvider>(context, listen: false).init();
            Future.microtask(() {
              Provider.of<CommentInfiniteProvider>(context, listen: false).fetchItems(ddayId: dDayId);
            });
          });
          Get.back();
        } else {
          Get.back();
        }
      },
    );
  }

  _action1(String userName, bool result) {
    var message;
    result == true ? message = userName + "님을 신고했습니다." : message = "이미 신고하였습니다";
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _action2(String userName, bool result) {
    print(userName);
  }

  _action3(String userName, bool result) {
    var message;
    if (result == true) {
      message = "코멘트를 삭제하였습니다";
    } else {
      message = "다시 시도해주세요";
    }

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
