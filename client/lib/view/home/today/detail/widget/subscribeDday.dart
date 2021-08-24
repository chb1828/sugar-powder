import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar_client/service/dday_service.dart';


class SubScribeDday extends StatefulWidget {
  int ddayId;

  @override
  _SubScribeDdayState createState() => _SubScribeDdayState();
  SubScribeDday(this.ddayId);
}

class _SubScribeDdayState extends State<SubScribeDday> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          var result = await DDayPostService().followDday(widget.ddayId);
          if (result == true) {
            Get.offAndToNamed("/detail/${widget.ddayId}");
          }
        },
        child: Container(
          height: 90,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
              child: Text(
                "디데이 구독하기",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ));
  }
}