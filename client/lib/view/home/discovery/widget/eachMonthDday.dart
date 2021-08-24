import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sugar_client/view/dDaySearch/resultsbyMonth.dart';
import 'package:sugar_client/view/home/discovery/widget/eachMonthDdayTile.dart';

class EachDday extends StatefulWidget {
  @override
  _EachDdayState createState() => _EachDdayState();
}

class _EachDdayState extends State<EachDday> {
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 36, 0, 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "월별 디데이",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 0, 0),
            child: EachMonthDdayTile([
              ["🌞", "1", Color.fromRGBO(94,222,227, 1.0), "새해복많이"],
              ["🍫", "2", Color.fromRGBO(255,164,137, 1.0), "초콜릿원츄"]
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 0, 0),
            child: EachMonthDdayTile([
              ["🍭", "3", Color.fromRGBO(207,202,247, 1.0), "사탕은살쪄"],
              ["🌸", "4", Color.fromRGBO(236,104,137, 1.0), "벚꽃놀이"]
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 0, 0),
            child: EachMonthDdayTile([
              ["👵🏻", "5", Color.fromRGBO(90,238,135,1.0), "어른이날"],
              ["🌴", "6", Color.fromRGBO(108,231,255, 1.0), "녀름"]
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 0, 0),
            child: EachMonthDdayTile([
              ["✈️", "7", Color.fromRGBO(160,197,255, 1.0), "휴가철"],
              ["🇰🇷", "8", Color.fromRGBO(126,164,255, 1.0), "광복절"]
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 0, 0),
            child: EachMonthDdayTile([
              ["🍁", "9", Color.fromRGBO(255,120,78, 1.0), "천고마비"],
              ["🎃", "10", Color.fromRGBO(255,184,10, 1.0), "Trick or Treat"],
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 0, 0),
            child: EachMonthDdayTile([
              ["👜", "11", Color.fromRGBO(131,78,255, 1.0), "본격세일시즌"],
              ["🌲", "12", Color.fromRGBO(40,166,179, 1.0), "크리스마스"],
            ]),
          ),
          SizedBox(height: 36,)
        ],
      ),
    );
  }
}
