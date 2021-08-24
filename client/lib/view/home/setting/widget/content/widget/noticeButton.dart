import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoticeButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: FlatButton(
              padding: EdgeInsets.all(0),
              color: Colors.transparent,
              splashColor: Colors.black26,
              onPressed: () {
                Get.toNamed("/settings/notice");
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text("내 알림",
                      style: TextStyle(fontSize: 15)),
                    flex: 20,
                  ),
                ],
              )
          ),
        )
      ],
    );
  }
}