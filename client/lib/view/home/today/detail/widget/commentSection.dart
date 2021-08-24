import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sugar_client/constant/constant.dart';
import 'package:sugar_client/dto/comment/comment_dto.dart';
import 'package:sugar_client/provider/comment_infinite_provider.dart';
import 'package:sugar_client/util/calculator.dart';
import 'package:sugar_client/view/home/today/detail/widget/commentModalOption.dart';

class CommentSection extends StatefulWidget {
  @override
  _CommentSectionState createState() => _CommentSectionState();
  var dDayObj;
  // String title;
  CommentSection(this.dDayObj);
}

class _CommentSectionState extends State<CommentSection> {
  Future<List<CommentDTO>> _futureCommentList;
  List<CommentDTO> _commentData = [];
  List<String> usedDays = [];
  var firstBorderStyle;
  var secondBorderStyle;
  var tagStyle;
  BottomPopup bottomPopUpNav = new BottomPopup();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CommentInfiniteProvider>(context, listen: false).init();
    Future.microtask(() {
      Provider.of<CommentInfiniteProvider>(context, listen: false).fetchItems(ddayId: widget.dDayObj.id);
    });
  }


  @override
  Widget build(BuildContext context) {
    // print(_commentData[0].createTime.runtimeType);

    //  print(widget.dDayObj.id);
    final provider = Provider.of<CommentInfiniteProvider>(context);

    var cache = provider.cache;

    var loading = provider.loading;


    //로딩중이면서 캐시에 아무것도 없음
    if(cache==null || loading && cache.length == 0) {
      return Container(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Center(
            child: CircularProgressIndicator(),
          )
      );
    }

    //로딩중이 아닌데 캐시에 아무것도 없음
    //아무것도 가져올 아이템이 없을때
    if(!loading && cache.length == 0) {
      return Container(
          height: MediaQuery.of(context).size.height*(0.15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "😄",
                  style: TextStyle(fontSize: 40),
                ),
                SizedBox(height: 4),
                Text(
                  "댓글을 써보세요!",
                  style: TextStyle(
                      color: Color.fromRGBO(
                          102, 102, 102, 1),
                      fontSize: 20),
                )
              ],
            ),
          )
      );
    }


    return Container(
      // color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            commentHeader(""),
            SizedBox(
              height: 15,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cache.length + 1,
              itemBuilder: (context, index) {

                  if (index < cache.length) {
                    return comment(
                        cache[index].createTime,
                        // getCommentedDdays(widget.dDayObj.date),
                        // getCommentedDdays(widget.dDayObj.date),
                        "${cache[index].nickname}",
                        cache[index].owner,
                        "${cache[index].comment}",
                        cache[index].id
                    );
                  }

                  if(!provider.loading && provider.hasMore) {

                    Future.microtask(() {
                      provider.fetchItems(ddayId: widget.dDayObj.id);
                    });
                  }

                  if(provider.hasMore) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }else {
                    return Container();
                  }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget commentHeader(String commentDatLength) {
    return  Container(
        child: Row(
          children: [
            Text(
              '한마디',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
              child: Text(
                "$commentDatLength",
                style: TextStyle(
                    fontSize: 16.0,
                    color: grayColor,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        )
    );
  }

  Widget comment(dDay, username, owner, comment, commentId) {
    return Column(
      children: [
        commentAreaTop(false),
        commentAreaMiddle(dDay, Icons.radio_button_checked, username, owner,
            commentId, widget.dDayObj.id),
        commentAreaBottom(comment, commentId),
      ],
    );
  }

  Widget commentAreaTop(topBorderDisplay) {
    if (topBorderDisplay == true) {
      firstBorderStyle = Border(
          top: BorderSide(color: Colors.grey[300], width: 1.0),
          right: BorderSide(color: Colors.grey[300], width: 1.0));
      secondBorderStyle =
          Border(top: BorderSide(color: Colors.grey[300], width: 1.0));
    } else {
      firstBorderStyle =
          Border(right: BorderSide(color: Colors.grey[300], width: 1.0));
      secondBorderStyle = null;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(border: firstBorderStyle),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            decoration: BoxDecoration(
                //  color: Colors.red,
                border: secondBorderStyle),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
            ),
          ),
        ),
      ],
    );
  }

  Widget commentAreaMiddle(
      createdCommentDate, passedIcon, userName, owner, commentId, dDayId) {
    // print("owner: ${tag}");
    var dDayRecordDate = widget.dDayObj.date;
    var getDday = getCommentedDdays(dDayRecordDate, createdCommentDate);
    var leftDday;
    //dday가 포함되어있는지 아닌지 확인합니다.
    if (usedDays.contains(getDday['leftDday'])) {
      leftDday = "";
    } else {
      usedDays.add(getDday['leftDday']);
      leftDday = getDday['leftDday'];
    }

    // if (tag.length > 0) {
    //   tagStyle = BoxDecoration(
    //     color: Colors.grey[300],
    //     borderRadius: BorderRadius.circular(10),
    //   );
    // } else {
    //   tagStyle = null;
    // }
    tagStyle = null;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  // top: BorderSide(color: Colors.grey[300], width: 1.0),
                  // right: BorderSide(color: Colors.grey[300], width: 1.0),
                  ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  leftDday,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Center(
                child: Icon(
                  passedIcon,
                  size: 18,
                  color: Colors.amber[600],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  // top: BorderSide(color: Colors.grey[300], width: 1.0),
                  ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //유저네임
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Text(
                          userName,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: tagStyle,
                        margin: const EdgeInsets.fromLTRB(1, 0, 0, 0),
                        //만든이
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Center(
                              // child: Text(
                              //   owner,
                              //   style: TextStyle(fontSize: 10),
                              // ),
                              ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () => bottomPopUpNav.mainBottomSheet(context,
                                userName: userName,
                                commentId: commentId,
                                owner: owner,
                                dDayId: dDayId),
                            child: Icon(Icons.more_vert),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget commentAreaBottom(comment, commentId) {
    print(commentId);
    return Container(
      // color: Colors.blue,
      margin: EdgeInsets.fromLTRB(0, 10, 5, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              // height: 50,
              // color: Colors.blue,
              decoration: BoxDecoration(
                  // color: Colors.amber,

                  // border: Border(
                  //   right: BorderSide(color: Colors.grey[300], width: 1.0),
                  // ),
                  ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              // color: Colors.red,
              decoration: BoxDecoration(
                // color: Colors.amber,

                border: Border(
                  left: BorderSide(color: Colors.grey[300], width: 1.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 20, 15),
                child: Text(comment),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
