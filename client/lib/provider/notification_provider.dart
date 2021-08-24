import 'package:flutter/material.dart';
import 'package:sugar_client/service/dday_service.dart';

class NotificationProvider extends ChangeNotifier {
  bool _notification;
  Color get notiColour => _notification == true ? Colors.yellow : Colors.white;

  setNotiValue(passedValue){
    if(passedValue == true){
      _notification = true;
    }else{
      _notification = false;
    }
    notifyListeners();
  }

  Future _manageNotification({@required int dDayId, @required bool status}) async {
    return  DDayPostService().manageNotification(dDayId,status);
  }

  bool subscribe(dDayId){
    if(_notification == true){
      _manageNotification(dDayId: dDayId, status: false);
      _notification = false;
    }else{
      _manageNotification(dDayId: dDayId, status: true);
      _notification = true;
    }
  
    notifyListeners();
    return _notification;
  }

  initNotificationData({
    bool notification,
  }) async {
    _notification = notification;
  }

  bool getNotiState() {
    return _notification;
  }
}
