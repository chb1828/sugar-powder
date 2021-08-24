import 'package:flutter/material.dart';
import 'package:get/get.dart';

@deprecated
class IntroduceButton extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FlatButton(
              padding: EdgeInsets.all(0),
              color: Colors.transparent,
              splashColor: Colors.black26,
              onPressed: () {
                Get.toNamed("/introduce");
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text("슈가파우더 소개",
                        style: TextStyle(fontSize: 15)),
                    flex: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Colors.grey,
                    ),
                  )
                ],
              )
          ),
        )
      ],
    );
  }

}