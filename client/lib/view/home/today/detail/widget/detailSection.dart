import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sugar_client/constant/constant.dart';
import 'package:sugar_client/provider/notification_provider.dart';

class DetailSection extends StatefulWidget {
  @override
  _DetailSectionState createState() => _DetailSectionState();
  var dDayObj;

  // String title;
  DetailSection(this.dDayObj);
}

class _DetailSectionState extends State<DetailSection> {
  NotificationProvider _notificationProvider;

  //  @override
  // void initState() {
  //   super.initState();

  // }
  @override
  void initState() {
    super.initState();
    Provider.of<NotificationProvider>(context, listen: false)
        .initNotificationData(notification: widget.dDayObj.noti);
    //  Future.microtask(() => {
    //    Provider.of<NotificationProvider>(context, listen: false).initNotificationData(notification: widget.dDayObj.noti)
    // });
    // final _store = Provider.of<NotificationProvider>(context).setNotiValue(widget.dDayObj.noti);
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<NotificationProvider>(context).setNotiValue(widget.dDayObj.noti);
    _notificationProvider = Provider.of<NotificationProvider>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      "${widget.dDayObj.title}",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  flex: 9,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        String notiText = "";
                        bool check =
                            _notificationProvider.subscribe(widget.dDayObj.id);
                        check
                            ? notiText = "디데이 알림이 신청 되었습니다"
                            : notiText = "디데이 알림이 취소 되었습니다";
                        Fluttertoast.showToast(
                            msg: notiText,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(51, 51, 51, 1.0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Provider.of<NotificationProvider>(context)
                                    .getNotiState()
                                ? SvgPicture.asset(
                                    "assets/icons/iconNotificationOn.svg",
                                    width: 23,
                                    height: 23,
                                  )
                                : SvgPicture.asset(
                                    "assets/icons/iconNotificationOff.svg",
                                    width: 23,
                                    height: 23,
                                  ),
                          )
                          // child: Icon(Icons.add_alert),
                          ),
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 21),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${widget.dDayObj.ownerNickname} 외 ${widget.dDayObj.followerCount - 1}명', //followerCount는 자기 자신도 포함하고있기 때문에 -1 해준다. 아마도 자기가 만든 게시글은 디폴트로 팔로우 하고 있는듯?
                    style: TextStyle(
                      color: grayColor,
                    ),
                  ),
                ),
              ),
            ),
            //First Row
            // detailSectionContent("일정", "2020년 12월 31일 오후 13시 30분"),
            detailSectionContent(
                "assets/icons/iconDate.svg", "${widget.dDayObj.dateTime}"),
            detailSectionContent(
                "assets/icons/iconLocation.svg", "${widget.dDayObj.place}"),
            detailSectionContent("assets/icons/iconExplain.svg",
                "${widget.dDayObj.description}"),
            Divider(
              color: Colors.white,
              height: 20,
            ),
            Row(
              children: <Widget>[
                for (var tag in widget.dDayObj.tags) tagItems("${tag}"),
              ],
            ),

            SizedBox(height: 24),
            Divider(),
            SizedBox(height: 29),
          ],
        ),
      ),
    );
  }

  Widget tagItems(tagText) {
    return GestureDetector(
        onTap: () {
          Get.offAndToNamed("/search/tag", arguments: tagText);
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(244, 245, 246, 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '#',
                    style: TextStyle(fontSize: 14.0, color: grayColor),
                  ),
                  TextSpan(
                    text: tagText,
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget detailSectionContent(headerIcon, content) {
    if (content.length > 0) {
      return Padding(
          padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Transform(
                    transform: Matrix4.translationValues(0.0, 3, 0.0),
                    child: SvgPicture.asset(
                      headerIcon,
                      width: 21,
                      height: 21,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    "${content}",
                    // overflow: content.length > 20 ? TextOverflow.ellipsis : null,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        );
    } else {
      return Container();
    }
  }
}
