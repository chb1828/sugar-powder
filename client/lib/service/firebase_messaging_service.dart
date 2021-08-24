import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:sugar_client/service/storage_service.dart';

class FirebaseMessagingService {
  final storage = FlutterSecureStorage();
  
  //initlaise the functions
  pushMessageInitilaise(){
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    
    configuration(_firebaseMessaging);
    requestNotificationPermissions(_firebaseMessaging);
    if(Platform.isIOS) {
      onIosSettingsRegistered(_firebaseMessaging);
    }
    getToken(_firebaseMessaging);
  }

  configuration(_firebaseMessaging) {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        if(message['data']['ddayId'] !=null ) {
          Get.toNamed("/detail/${message['data']['ddayId']}");
        }
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        if(message['data']['ddayId'] !=null ) {
            Get.toNamed("/detail/${message['data']['ddayId']}");
        }
        // _navigateToItemDetail(message);
      },
    );
  }

  requestNotificationPermissions(_firebaseMessaging) {
    const IosNotificationSettings(
        sound: true, badge: true, alert: true, provisional: true);
  }

  onIosSettingsRegistered(_firebaseMessaging) {
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  getToken(_firebaseMessaging) {
    _firebaseMessaging.getToken().then((String token) async {
      assert(token != null);
      StorageService().saveDeviceToken(token);
      print('device_token : $token');
    });
  }
}
