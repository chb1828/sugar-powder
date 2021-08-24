import 'package:flutter/material.dart';
import 'package:sugar_client/util/calculator.dart';

class HeroSection extends StatefulWidget {
  @override
  _HeroSectionState createState() => _HeroSectionState();

  var dDayObj;
  HeroSection(this.dDayObj);
}

class _HeroSectionState extends State<HeroSection> {
  @override
  Widget build(BuildContext context) {
    //SET VALUES
    int formatedbgColor = int.parse("0x" + widget.dDayObj.color);
    var results = getLeftDdays(widget.dDayObj.date);
    var leftDday = results['leftDday'];
    var introDate = widget.dDayObj.dateTime.split('.');
    return Container(
      height: 156,
      color: Color(formatedbgColor),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      "${introDate[0]}년 ${introDate[1]}월 ${introDate[2][0]}${introDate[2][1]}일 까지",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(34, 34, 34, 0.5),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Center(
                        child: Text(
                      "${widget.dDayObj.emoji} ${leftDday}",
                      style: TextStyle(fontSize: 56),
                    )),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
