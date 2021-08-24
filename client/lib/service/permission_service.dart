import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  setPermission() async {
    if(await Permission.notification.isUndetermined) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.notification,
      ].request();
    }else if(await Permission.notification.isRestricted){
      print("${await Permission.notification.status} 제한됨");
    }else if(await Permission.notification.isRestricted) {
      print("${await Permission.notification.status} 거절됨");
    }else if(await Permission.notification.isGranted) {
      print("${await Permission.notification.status} 승인됨");
    }
  }

   getNotificationPermission() async {
    bool check = await Permission.notification.isGranted;
    return check;
  }
}