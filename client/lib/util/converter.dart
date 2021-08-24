import 'dart:collection';
import 'dart:ui';

import 'package:intl/intl.dart';

class Converter {
  String convertToDate(String date, String time) {
    if (time.isEmpty) {
      time = "0시 0분";
    }
    var _dateFormat = date.split(" ");
    String year = _dateFormat[0].substring(0, _dateFormat[0].length - 1);
    String month = _dateFormat[1].substring(0, _dateFormat[1].length - 1);
    String day = _dateFormat[2].substring(0, _dateFormat[2].length - 1);
    var _timeFormat = time.split(" ");
    String hour = _timeFormat[0].substring(0, _timeFormat[0].length - 1);
    String minute = _timeFormat[1].substring(0, _timeFormat[1].length - 1);
    if (int.parse(hour) < 10) {
      hour = "0$hour";
    }
    if (int.parse(minute) < 10) {
      minute = "0$minute";
    }
    return DateFormat("yyyy-MM-ddTHH:mm:ss").format(
        DateTime.parse(year + month + day + "T" + hour + minute + "00"));
  }

  Map<String, String> convertToText(String date) {
    var _dateFormat = date.split("T");
    var _dateFormat2 = _dateFormat[0].split("-");
    String year = _dateFormat2[0];
    String month = _dateFormat2[1];
    String day = _dateFormat2[2];
    var _timeFormat = _dateFormat[1].split(":");
    String hour = _timeFormat[0];
    String minute = _timeFormat[1];
    if ('${hour[0]}' == '0') {
      hour = "${hour[1]}";
    }
    if ('${minute[0]}' == '0') {
      minute = "${minute[1]}";
    }
    String fDate = "$year년 $month월 $day일";
    String fTime = "$hour시 $minute분";
    Map<String, String> map = HashMap();
    map["date"] = fDate;
    map["time"] = fTime;
/*    if(int.parse(hour) < 10) {
      hour = "0$hour";
    }
    if(int.parse(minute) < 10) {
      minute = "0$minute";
    }*/
    return map;
  }

  Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}