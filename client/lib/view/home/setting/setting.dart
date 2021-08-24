import 'package:flutter/material.dart';
import 'package:sugar_client/view/home/setting/widget/content/settingContent.dart';
import 'package:sugar_client/view/home/setting/widget/header/settingHeder.dart';

class Setting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SettingHeader(),
            ),
            Expanded(
              flex: 5,
              child: SettingContent(),
            )

          ],
        ));
  }
}




