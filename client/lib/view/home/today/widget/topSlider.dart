import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar_client/constant/constant.dart';
import 'package:sugar_client/dto/dday/dday_list_dto.dart';
import 'package:sugar_client/service/dday_service.dart';
import 'package:sugar_client/util/calculator.dart';
import 'package:sugar_client/view/home/today/widget/textBox.dart';

class TopSlider extends StatefulWidget {
  String whichScreen;
  TopSlider(this.whichScreen);

  @override
  State<StatefulWidget> createState() => _TopSliderState();
}

class _TopSliderState extends State<TopSlider> {
  Future<List<DDayListDTO>> _future;
  List<DDayListDTO> _data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _future = loadData();
    });
  }

  Future<List<DDayListDTO>> loadData() async {
    if (widget.whichScreen == "discoveryScreen") {
      //발견 화면일때는 popular dday를 가져오고
      _data = _data + await DDayPostService().getPopularDday();
      // _data = _data.sort((a, b) => a.date.compareTo(b.date));
      // _data = _data.reversed.toList();
    } else {
      //오늘 탭에서는 오늘 디데이
      _data = _data + await DDayPostService().getTodayTopDDays();
    }
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: _future, // async work
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (_data.length > 0) {
              return Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Container(
                     
                      child: CarouselSlider(
                        
                        height: 173,
                        // aspectRatio: 2.0,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: false,
                        items: [
                          for (var item in _data)
                        
                            cardInnerRecord(
                                width,
                                item.color,
                                item.emoji,
                                item.title,
                                item.description,
                                item,
                                item.followerCount)
                        ],
                        // autoPlay: true,
        
                        autoPlayInterval: const Duration(seconds: 6),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        // enableInfiniteScroll: false,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 3000),
                        viewportFraction: 0.83
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }
          return Container(
            height: MediaQuery.of(context).size.height / 10 * 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator()],
            ),
          );
        });
  }

  cardInnerRecord(
      width, cardBg, dDayEmoji, dDayTitle, dDayInfo, dDay, followCount) {
    var cardBgColour = "0x${cardBg}";
    int parsedBgColor = int.parse(cardBgColour);
    var topText;
    var finalDDayEmoji;
    var dDayInfoLastLine;
    var displayDate = parseDate(dDay.date);

    if (widget.whichScreen == "todayScreen") {
      topText = "오늘은";
      dDayInfoLastLine = dDayInfo;
    } else {
      var leftDays = getLeftDdaysBasedOnPassed(dDay.date);
      topText = leftDays['leftDday'];
      dDayInfoLastLine = parseDate(dDay.date);
    }

    dDayEmoji.length > 0 ? finalDDayEmoji = dDayEmoji : finalDDayEmoji = "🌸";

    return Transform(
      // color: Colors.red,
      transform: Matrix4.translationValues(-30, 0.0, 0.0),
      child: FlatButton(
          onPressed: () {
            Get.toNamed("/detail/${dDay.id}");
          },
          child: Container(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 26, 0, 5),
              height: 173,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(parsedBgColor),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(60, 119, 179, 0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Transform(
                        transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                        child: Text(
                          finalDDayEmoji,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 70,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 4.0),
                                blurRadius: 1.0,
                                color: Color.fromRGBO(0, 0, 0, 1.2),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: TextBox(
                                '${topText}', homeTopCardSliderTextFirst),
                          ),
                          Divider(
                            height: 6.6,
                            color: Colors.transparent,
                          ),
                          Expanded(
                            child: TextBox(
                              dDayTitle,
                              TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 10),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                TextBox(
                                  "${displayDate}",
                                  TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1.0),
                                      fontSize: 7),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(4.0, 0, 0, 0),
                                ),
                                Icon(
                                  Icons.brightness_1,
                                  size: 4,
                                  color: Color.fromRGBO(255, 255, 255, 1.0),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(4.0, 0, 0, 0),
                                ),
                                TextBox(
                                  "${followCount}명",
                                  TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1.0),
                                      fontSize: 7),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
