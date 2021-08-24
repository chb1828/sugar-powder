import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar_client/view/dDaySearch/resultsbyMonth.dart';

class EachMonthDdayTile extends StatefulWidget {
  @override
  List monthData;
  EachMonthDdayTile(this.monthData);
  _EachMonthDdayTileState createState() => _EachMonthDdayTileState();
}

class _EachMonthDdayTileState extends State<EachMonthDdayTile> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        children: <Widget>[
          //["🌞", "1월", Colors.blue[200]
          item(widget.monthData[0][0], widget.monthData[0][2],
              widget.monthData[0][1], widget.monthData[0][3], width),
          item(widget.monthData[1][0], widget.monthData[1][2],
              widget.monthData[1][1], widget.monthData[1][3], width)
        ],
      ),
    );
  }

  Widget item(icon, bgColor, month, hashTag, width) {
    var parsedMonth = int.parse(month);
    var initialOffset;
    if(parsedMonth == 1 || parsedMonth == 2 || parsedMonth == 3){
      initialOffset = 0.0;
    }else if((parsedMonth == 4 || parsedMonth == 5 || parsedMonth == 6)){
      initialOffset = width/3;
    }else if((parsedMonth == 7 || parsedMonth == 8 || parsedMonth == 9)){
      initialOffset = width/2;
    }else if((parsedMonth == 10 || parsedMonth == 11 || parsedMonth == 12)){
      initialOffset = width/1;
    }
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () {
            print("먼스 $month");
            print("오프셋 $initialOffset");
            Get.toNamed("/search/month",arguments: ResultByMonthArguments(month, initialOffset));
          },
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    //Icon Background Color
                    borderRadius: BorderRadius.circular(10),
                    color: bgColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      icon,
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Container(
                          //1월
                          child: Text(
                            "${month}월",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Container(
                          child: Text(
                            hashTag,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(137, 137, 137, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
