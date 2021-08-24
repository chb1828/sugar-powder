import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar_client/service/storage_service.dart';
import 'package:sugar_client/view/home/setting/page/setProfilePage.dart';

class SettingHeader extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _SettingHeaderState();

}


class _SettingHeaderState extends State<SettingHeader>{

  String nickname = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getNickname();
    });
  }

   getNickname() async {
    await StorageService().getNickname().then((value) {
      setState(() {
        nickname = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
      padding: EdgeInsets.only(top: 50, left: 20, right: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        FlatButton(
                            padding: EdgeInsets.only(right: 15),
                            color: Colors.transparent,
                            splashColor: Colors.black26,
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=> SetProfilePage())
                              ).then((value) {
                                if(value!=null) {
                                  setState(() {
                                    nickname = value;
                                  });
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Text(nickname,
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                SizedBox(width: 5),
                                CircleAvatar(
                                  radius: 6,
                                  backgroundColor: Colors.grey,
                                  child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 9
                                  ),
                                )
                              ],
                            )
                        ),
                      ],
                    )
                  ],
                ),
              ),
              IconButton(
                icon: IconTheme(
                  data: IconThemeData(color: Colors.black),
                  child: Icon(Icons.close),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("카카오 아이디로 가입", style: TextStyle(
                  fontSize: 11, color: Colors.grey, height: 0.5)),
            ],
          )
        ],
      ),
    );
  }


}
