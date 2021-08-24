import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:share/share.dart';
import 'package:sugar_client/dto/dday/dday_list_dto.dart';
import 'package:sugar_client/service/dday_service.dart';
import 'package:sugar_client/service/firebase_share_service.dart';
import 'package:sugar_client/view/create/createDDay.dart';
import 'package:sugar_client/view/home/today/detail/widget/commentSection.dart';
import 'package:sugar_client/view/home/today/detail/widget/detailSection.dart';
import 'package:sugar_client/view/home/today/detail/widget/heroSection.dart';
import 'package:sugar_client/view/home/today/detail/widget/subscribeDday.dart';

import 'bottom.dart';

class DDayDetail extends StatefulWidget {

  @override
  _DDayDetailState createState() => _DDayDetailState();

}

class _DDayDetailState extends State<DDayDetail> {

  Future<DDayListDTO> _futuerGetDday;
  Future<bool> _futureIsUserFollowTheDday;
  var dDayObj;
  int id;

  @override
  void initState() {
    super.initState();
    id = int.parse(Get.parameters['id']);
    _futuerGetDday = DDayPostService().getOneDday(id);
    _futureIsUserFollowTheDday =
        DDayPostService().checkifFollowedDday(id);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int formatedbgColor;
    return FutureBuilder(
      future: _futuerGetDday, // async work
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError)
              return Scaffold(
                  body: Center(child: Text('Error: ${snapshot.error}')));
            else
              dDayObj = snapshot.data;
            print(dDayObj);
            formatedbgColor = int.parse("0x" + dDayObj.color);
            // print(dDayObj.owner);
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Get.back(),
                ),
                backgroundColor: Color(formatedbgColor),
                actions: [
                  Padding(
                      padding: EdgeInsets.only(right: 3.0),
                      child: GestureDetector(
                        child: SvgPicture.asset(
                          "assets/icons/iconShareIOs.svg",
                          width: 24,
                          height: 24,
                        ),
                        onTap: () async {
                          var uri =
                              await ShareService().getDynamicLink(dDayObj);
                          Share.share(
                            uri.toString(), //동적 링크 생성되야할 부분
                            subject: "'${dDayObj.title}' 디데이 같이 기다릴래요?",
                          );
                        },
                      )

                      // IconButton(
                      //   icon: Icon(Icons.share, color: Colors.black),
                      //   onPressed: () async {
                      //     var uri =
                      //         await ShareService().getDynamicLink(dDayObj);
                      //     Share.share(
                      //       uri.toString(), //동적 링크 생성되야할 부분
                      //       subject: dDayObj.title,
                      //     );
                      //   },
                      // ),

                      ),
                  dDayObj.owner
                      ? threeDotPopupsForOwners()
                      : threeDotPopupsForNormalUsers()
                ],
              ),
              body: FutureBuilder(
                future: _futureIsUserFollowTheDday, // async work
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      if (snapshot.hasError)
                        return Scaffold(
                            body: Center(
                                child: Text('Error: ${snapshot.error}')));
                      else if (snapshot.data == true) {
                        return FooterLayout(
                          footer: BottomTabs(dDayObj.id),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const ClampingScrollPhysics(),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //가장 위쪽의 메인 아이콘과 남은 디데이들을 표시해주는 섹션입니다.
                                HeroSection(dDayObj),
                                //중간의 디데이의 디테일들을 보여주는 섹션입니다.
                                DetailSection(dDayObj),
                                //마지막의 코멘트들을 관리하는 섹션입니다.
                                CommentSection(dDayObj),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return FooterLayout(
                          footer: SubScribeDday(dDayObj.id),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const ClampingScrollPhysics(),
                            
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //가장 위쪽의 메인 아이콘과 남은 디데이들을 표시해주는 섹션입니다.
                                HeroSection(dDayObj),
                                //중간의 디데이의 디테일들을 보여주는 섹션입니다.
                                DetailSection(dDayObj),
                                //마지막의 코멘트들을 관리하는 섹션입니다.
                                CommentSection(dDayObj),
                              ],
                            ),
                          ),
                        );
                      }
                  }
                },
              ),
            );
          // resizeToAvoidBottomPadding: false
        }
      },
    );
  }

  threeDotPopupsForOwners() {
    return Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: IconButton(
          icon: Icon(Icons.more_vert, color: Colors.black),
          onPressed: () async {
            final act = CupertinoActionSheet(
                //title: Text('Select Option'),
                //message: Text('Which option?'),
                actions: <Widget>[
                  CupertinoActionSheetAction(
                    child: Text('수정하기'),
                    onPressed: () {
                      showCupertinoModalBottomSheet(
                              expand: true,
                              barrierColor: Color.fromRGBO(178, 178, 178, 60.0),
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => CreateDDay(dDayObj)).then((value) {
                                print("$value 의 값");
                                if(value !=null) {
                                  // 두번푸시.. 바꿔야 할듯
                                  Get.offAllNamed("/home");
                                  // Get.offAllNamed("/today",arguments: "CREATE");
                                  Get.toNamed("/detail/$value");
                                }
                      });
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: Text(
                      '삭제하기',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      _showModal();
                    },
                  )
                ],
                cancelButton: CupertinoActionSheetAction(
                  child: Text('닫기'),
                  onPressed: () {
                    Get.back();
                  },
                ));
            showCupertinoModalPopup(
                context: context, builder: (BuildContext context) => act);
          },
        )
        //Icon(Icons.more_vert, color: Colors.black),
        );
  }

  threeDotPopupsForNormalUsers() {
    return FutureBuilder(
        future: _futureIsUserFollowTheDday, // async work
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Padding(padding: EdgeInsets.only(right: 3.0)
                  // child: CircularProgressIndicator(),
                  );
            default:
              if (snapshot.hasError)
                return Padding(padding: EdgeInsets.only(right: 3.0));
              // return Scaffold(
              //     body: Center(child: Text('Error: ${snapshot.error}')));
              else if (snapshot.data == true) {
                return Padding(
                  padding: EdgeInsets.only(right: 3.0),
                  child: IconButton(
                    icon: Icon(Icons.more_vert, color: Colors.black),
                    onPressed: () async {
                      final act = CupertinoActionSheet(
                          //title: Text('Select Option'),
                          //message: Text('Which option?'),
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              child: Text('디데이 신고하기'),
                              onPressed: () async {
                                var result = await DDayPostService()
                                    .reportDday(id);
                                print(result);
                                if (result == true) {
                                  Fluttertoast.showToast(
                                          msg: "디데이를 신고 하였습니다.",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0)
                                      .then((value) {
                                    Get.back();
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                          msg: "이미 신고하였습니다.",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0)
                                      .then((value) {
                                    Get.back();
                                  });
                                }
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text(
                                '디데이 구독 취소하기',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () async {
                                var result = await DDayPostService()
                                    .unfollowDday(id);
                                if (result == true) {
                                  var name =
                                      ModalRoute.of(context).settings.name;
                                  // print(name);
                                  Get.back();
                                  Get.offAndToNamed("/detail/$id");
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "문제가 발생했습니다. 다시 시도해 주세요.",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                                // _showModal();
                              },
                            )
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: Text('닫기'),
                            onPressed: () {
                              Get.back();
                            },
                          ));
                      showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) => act);
                    },
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.only(right: 3.0),
                  child: IconButton(
                    icon: Icon(Icons.more_vert, color: Colors.black),
                    onPressed: () async {
                      final act = CupertinoActionSheet(
                          //title: Text('Select Option'),
                          //message: Text('Which option?'),
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              child: Text('디데이 신고하기'),
                              onPressed: () async {
                                var result = await DDayPostService()
                                    .reportDday(id);
                                print(result);
                                if (result == true) {
                                  Fluttertoast.showToast(
                                          msg: "디데이를 신고 하였습니다.",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0)
                                      .then((value) {
                                    Get.back();
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                          msg: "이미 신고하였습니다.",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0)
                                      .then((value) {
                                    Get.back();
                                  });
                                }
                              },
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: Text('닫기'),
                            onPressed: () {
                              Get.back();
                            },
                          ));
                      showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) => act);
                    },
                  ),
                );
              }
          }
        });
  }

  void _showModal() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0))),
        context: context,
        builder: (builder) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 230.0,
            padding: EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "정말 디데이를 삭제하시겠어요?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text("삭제하시면 다시 복구할 수 없어요",
                    style: TextStyle(color: Colors.grey)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 4,
                        child: Padding(
                            padding:
                                EdgeInsets.only(left: 5, right: 5, top: 40),
                            child: ButtonTheme(
                              height: 50,
                              child: RaisedButton(
                                color: Colors.white,
                                elevation: 0,
                                child: Text("아니요"),
                                onPressed: () => {
                                  Get.back()
                                },
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                      style: BorderStyle.solid)),
                            ))),
                    Expanded(
                        flex: 6,
                        child: Padding(
                            padding:
                                EdgeInsets.only(left: 5, right: 5, top: 40),
                            child: ButtonTheme(
                                height: 50,
                                child: RaisedButton(
                                  color: Color.fromRGBO(235, 82, 82, 1.0),
                                  child: Text("삭제할래요",
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () async {
                                    DDayPostService().removeDday(id);
                                    Fluttertoast.showToast(
                                            msg: "디데이가 삭제되었습니다.",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 16.0)
                                        .then((value) =>  Get.offAllNamed("/home")
                                    );
                                  },
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ))))
                  ],
                )
              ],
            ),
          );
        });
  }
}
