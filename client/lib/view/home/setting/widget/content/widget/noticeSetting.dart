import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sugar_client/service/storage_service.dart';
import 'package:sugar_client/service/user_service.dart';

class NoticeSetting extends StatefulWidget {
  @override
  _NoticeSettingState createState() => _NoticeSettingState();
}

class _NoticeSettingState extends State<NoticeSetting> {

  bool isSwitched = false;
  @override
  void initState() {
    StorageService().getUserNoti().then((value) {
      setState(() {
        isSwitched = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return            Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Text("전체 알람",
                    style: TextStyle(fontSize: 15)),
                flex: 5,
              ),
              Expanded(
                  flex: 1,
                  child: Transform.scale(
                    scale: 0.8,
                    child: Platform.isIOS ? CupertinoSwitch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          UserService().updateNoti(value).then((rValue) {
                            setState(() {
                              isSwitched = rValue;
                            });
                          });
                        });
                      },
                      activeColor: Colors.black26,
                    ) : Switch(
                      value: isSwitched,
                      onChanged: (value) {
                          UserService().updateNoti(value).then((complete) {
                            setState(() {
                              isSwitched = complete;
                            });
                          });
                      },
                      activeTrackColor: Colors.black26,
                      activeColor: Colors.black26,
                    ),
                  )
              ),
            ],
          ),
        )
      ],
    );
  }


}