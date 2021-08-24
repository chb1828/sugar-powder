import 'package:flutter/material.dart';
import 'package:sugar_client/view/home/setting/widget/content/widget/noticeSetting.dart';
import 'package:sugar_client/view/home/setting/widget/content/widget/policyButton.dart';
import 'package:sugar_client/view/home/setting/widget/content/widget/version.dart';
import 'widget/logoutButton.dart';
import 'widget/noticeButton.dart';
import 'widget/termsButton.dart';
import 'widget/withdrawButton.dart';

class SettingContent extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _SettingContentState();

}

class _SettingContentState extends State<SettingContent> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery
          .of(context)
          .size
          .height,
      padding: EdgeInsets.only(left: 20,right: 20),
      color: Colors.white,
      child: Column(
        children: [
          Divider( 
              color: Colors.grey
          ),
          // NoticeButton(),
          NoticeSetting(),
          SizedBox(height: 15,),
          Version(),
          SizedBox(height: 15,),
          PolicyButton(),
          SizedBox(height: 5,),
          //LicenceButton(),
          //IntroduceButton(),
          TermsButton(),
          SizedBox(height: 5,),
          LogoutButton(),
          SizedBox(height: 5,),
          WithdrawButton()
        ],
      ),
    );
  }

}

