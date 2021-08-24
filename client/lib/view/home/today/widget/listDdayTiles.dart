import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar_client/util/calculator.dart';

class DDayTile extends StatelessWidget {
  int id;
  String title;
  String icon;
  String dDayDate;
  String bgColor;
  String ddayType;
  int followerCount;

  DDayTile(this.id, this.title, this.icon, this.dDayDate, this.bgColor,
      this.ddayType, this.followerCount);

  @override
  Widget build(BuildContext context) {

   
    var results = getLeftDdays(dDayDate);
    var leftDday = results['leftDday'];
    var colourStartAndEnd = [];
    if(leftDday == "D-DAY"){
      colourStartAndEnd = [Color.fromRGBO(0,55,255, 1.0), Color.fromRGBO(190,42,229, 1.0)];
    }else{
      colourStartAndEnd = [Colors.black, Colors.black];
    }
    final Shader linearGradient = LinearGradient(
      colors: <Color>[colourStartAndEnd[0], colourStartAndEnd[1]],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 0.0, 0.0));

    var parsedDate = results['dDayDate'];
    int parsedBgColor = int.parse("0x" + bgColor);
    // print(followerCount);
    followerCount == null ? followerCount = 0 : followerCount = followerCount;
    // print("======");
    // print(title);
    // print(ddayType);
    // print('======');
    return InkWell(
      focusColor: Colors.grey[300],
      highlightColor: Colors.grey[300],
      onTap: () {
        Get.toNamed("/detail/$id");
      },
      child: Column(
        children: <Widget>[
          Container(
            child: ListTile(
              title: Container(
                child: Row(
                  children: <Widget>[
                    //Dday Title
                    Expanded(
                      flex: 6,
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 18)),
                          ),
                          ddayType == "PUBLIC"
                              ? Text("")
                              : ddayType == "PRIVATE"
                                  ? Icon(Icons.lock,
                                      color: Color.fromRGBO(137, 137, 137, 1.0),
                                      size: 18)
                                  : Text("")
                        ],
                      ),
                    ),
                    //Dday count
                    Expanded(
                      flex: 4,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            "${leftDday}",
                            
                            style: TextStyle(
                              foreground: Paint()..shader = linearGradient,
                              fontSize: 25,
                              // color: Color.fromRGBO(51, 51, 51, 1.0),
                              // foreground: Paint()..shader = dDayColour,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              subtitle: Row(
                children: [
                  Text(parsedDate),
                  Container(width: 3),
                  //follow count가 1 보다 많으면 무조건 보여주고 근데 이게 1보단 작다 ..그런데 public이다 그러면 아무것도 보여주지말고

                  followerCount > 1
                      ? Container(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Icon(
                            Icons.brightness_1,
                            size: 4,
                            color: Color.fromRGBO(137, 137, 137, 1.0),
                          ),
                        )
                      : ddayType == "PUBLIC"
                          ? Text("")
                          : Container(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Icon(
                                Icons.brightness_1,
                                size: 4,
                                color: Color.fromRGBO(137, 137, 137, 1.0),
                              ),
                            ),
                  followerCount > 1
                      ? Container(width: 3)
                      : ddayType == "PUBLIC"
                          ? Text("")
                          : Container(width: 3),
                  followerCount > 1
                      ? Text("${followerCount}명")
                      : ddayType == "PUBLIC"
                          ? Text("")
                          : Text("${followerCount}명")
                ],
              ),
              leading: Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    //Icon Background Color
                    color: Color(parsedBgColor),
                  ),
                  child: Center(
                    child: Text(
                      //Icon
                      icon,
                      style: TextStyle(
                        fontSize: 28,
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
            ),
          ),
          Divider(color: Colors.white)
        ],
      ),
    );
  }
}
