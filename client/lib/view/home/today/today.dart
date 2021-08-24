import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sugar_client/view/create/createDDay.dart';
import 'package:sugar_client/view/home/setting/setting.dart';
import 'package:sugar_client/view/home/today/widget/listDdays.dart';
import 'package:sugar_client/view/home/today/widget/listFilter.dart';
import 'package:sugar_client/view/home/today/widget/topSlider.dart';

class TodayScreen extends StatefulWidget {

  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {

  ScrollController _controller;
  String ddaySortType;

  @override
  void initState() {
    // ddaySortType = Get.arguments;
    ddaySortType = null;
    
    _controller =
        ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  }

  @override
  Widget build(BuildContext context) {
    //to responsive view.
/*    double height = MediaQuery.of(context).size.height;

    //자동으로 오늘 날짜로 업데이트
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy년 MM월 dd일');
    String formattedDate = formatter.format(now);*/

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: TopNavigation("오늘"),
      body: SingleChildScrollView(
        controller: _controller,
        physics: ScrollPhysics(),
        child: Column(
          children: [
            TopSlider("todayScreen"),
            ListFilter(),
            ListDDays(ddaySortType),
            SizedBox(height: 15,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCupertinoModalBottomSheet(
              expand: true,
              barrierColor: Color.fromRGBO(178, 178, 178, 80.0),
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => CreateDDay(null)).then((value) {
            if (value != null) {
              //두번 푸시하는데 비효율적
              Get.toNamed("/detail/$value");
              //Get.toNamed("/today",arguments: "CREATE");
              //_navigationService.navigateTo("/detail",arguments: value); 여기 변경!!!
            } else {
              return Container();
            }
          });
        },
        child: IconTheme(
          data: IconThemeData(color: Colors.white),
          child: Image.asset(
            "assets/icons/iconMake.png",
            width: 24,
            height: 24,
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
