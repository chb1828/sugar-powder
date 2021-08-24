import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sugar_client/view/home/setting/list/noticeTile.dart';

class NoticePage extends StatefulWidget{
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        title: Text("알림",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white70,
        actions: [
          FlatButton(
            child: Text("비우기"),
            onPressed: () => {
              Fluttertoast.showToast(
              msg: "비워졌습니다",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.lightBlue,
              textColor: Colors.white,
              fontSize: 16.0)
            },
          ),

        ],
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(6),
          children: [
            NoticeTile(Notice("😣","\"스터디 하기\"까지 1주일 남았습니다.","29분전")),
            NoticeTile(Notice("🤣","\"군 입대\"까지 100일 남았습니다.","37분전")),
            NoticeTile(Notice("🎂","드디어 \"ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ\"가 내일로 다가왔습니다.","1시간전")),
            NoticeTile(Notice("🤢","5회 이상 신고로 인해, \"ㅇㅇㅇ\" 캘린더가 삭제","2020.12.31"))
          ],
        )
      ),
    );
  }

}