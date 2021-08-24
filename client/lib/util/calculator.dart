
import 'package:intl/intl.dart';

getLeftDdays(dDayDate){
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(dDayDate);
    DateTime now = new DateTime.now(); 

    var result = now.difference(tempDate).inDays;
    var getDay = DateFormat('EEEE').format(tempDate);
    var getDayInKorean = getDayFromEnToKR(getDay);
    var formatedDate = DateFormat('yy.MM.dd (${getDayInKorean})').format(tempDate);
   
    var finalValue = {'leftDday' : "", 'dDayDate' : formatedDate};

    result = result -1 ;
    if(result == 0){
      if(DateFormat('yy.MM.dd').format(tempDate) == DateFormat('yy.MM.dd').format(now)){
         finalValue['leftDday'] = "D-DAY";
      }else{
        result = result + 2;
        finalValue['leftDday'] = "+${result}";
      }
    }else if(result < 0){
      //check dday date
      var parsedNowDate = new DateFormat("yyyy-MM-dd").parse(now.toString());
      if(parsedNowDate == tempDate){
        finalValue['leftDday'] = "D-DAY";
      }else{
        finalValue['leftDday'] = "${result}";
      }
      
    }else{
      result = result + 2;
      finalValue['leftDday'] = "+${result}";
    }


    return finalValue;
}

String getDetailDateTimeFormat(data) {
  String eDof = DateFormat('EEEE').format(DateTime.parse(data));
  String kDof = getDayFromEnToKR(eDof);
  String date = data.split("T")[0]; //2021-06-22
  String date2 = date.replaceAll('-', '.');
  String time = data.split("T")[1]; //04:18:00
  String time2 = "";
  if(time!="00:00:00")
    time2 = time.split(":")[0] + ":" +time.split(":")[1];
  String result = "$date2 ($kDof) $time2";
  return result;
}

getCommentedDdays(dDayDate, commentDate){
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(dDayDate);
    DateTime baseDate = new DateFormat("yyyy-MM-dd").parse(commentDate);

    var result = baseDate.difference(tempDate).inDays;

    var getDay = DateFormat('EEEE').format(tempDate);
    var getDayInKorean = getDayFromEnToKR(getDay);

    var formatedDate = DateFormat('yy.MM.dd (${getDayInKorean})').format(tempDate);
   
    var finalValue = {'leftDday' : "", 'dDayDate' : formatedDate};

    //
    if(result == 0){
      finalValue['leftDday'] = "D-DAY";
    }else if(result < 0){
      
      finalValue['leftDday'] = "D${result}";
    }else{
      finalValue['leftDday'] = "D+${result}";
    }

    return finalValue;
}

getLeftDdaysBasedOnPassed(dDayDate){
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(dDayDate);
    DateTime now = new DateTime.now(); 
    var result = now.difference(tempDate).inDays;

    var getDay = DateFormat('EEEE').format(tempDate);
    var getDayInKorean = getDayFromEnToKR(getDay);

    var formatedDate = DateFormat('yy.MM.dd (${getDayInKorean})').format(tempDate);
   
    var finalValue = {'leftDday' : "", 'dDayDate' : formatedDate};

    //
    result = result -1 ;
    if(result == 0){
      if(DateFormat('yy.MM.dd').format(tempDate) == DateFormat('yy.MM.dd').format(now)){
         finalValue['leftDday'] = "D-DAY";
      }else{
        result = result + 2;
        finalValue['leftDday'] = "+${result}";
      }
    }else if(result < 0){
      //check dday date
      var parsedNowDate = new DateFormat("yyyy-MM-dd").parse(now.toString());
      if(parsedNowDate == tempDate){
        finalValue['leftDday'] = "D-DAY";
      }else{
        finalValue['leftDday'] = "${result}";
      }
      
    }else{
      result = result + 2;
      finalValue['leftDday'] = "+${result}";
    }


    return finalValue;
}

parseDate(passedDate){
  DateTime passed = new DateFormat("yyyy-MM-dd").parse(passedDate);
  var getDay = DateFormat('EEEE').format(passed);
  var getDayInKorean = getDayFromEnToKR(getDay);
  var formatedDate = DateFormat('yy.MM.dd (${getDayInKorean})').format(passed);

  return formatedDate;
}


getDayFromEnToKR(dayInEng){
  var day;
  if(dayInEng == "Monday"){
    day = "월";
  }else if(dayInEng == "Tuesday"){
    day = "화";
  }else if(dayInEng == "Wednesday"){
    day = "수";
  }else if(dayInEng == "Thursday"){
    day = "목";
  }else if(dayInEng == "Friday"){
    day = "금";
  }else if(dayInEng == "Saturday"){
    day = "토";
  }else if(dayInEng == "Sunday"){
    day = "일";
  }

  return day;
}