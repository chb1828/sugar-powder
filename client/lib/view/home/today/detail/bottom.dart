import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:sugar_client/dto/comment/comment_common_dto.dart';
import 'package:sugar_client/provider/comment_infinite_provider.dart';
import 'package:sugar_client/service/storage_service.dart';
import 'package:sugar_client/service/comment_service.dart';

class BottomTabs extends StatefulWidget {
  int dDayId;
  bool isTheUserFollowTheDday = false;
  
  @override
  _BottomTabsState createState() => _BottomTabsState();
  BottomTabs(this.dDayId);
}

class _BottomTabsState extends State<BottomTabs> {
  Future<CommentCommonDTO> _futureComment;
  bool checkKeyboard = false;
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        checkKeyboard = isKeyboardVisible;
        return Container(
            height: 90,
            child: widget.isTheUserFollowTheDday == true
                ? currentlyUnfollow()
                : currentlyFollow());
          }
        );
      }

  currentlyFollow() {
    return Container(
        color: Color.fromRGBO(230, 231, 235, 1.0),
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: checkKeyboard
            ? RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (event) {

          },
          child: Row(
            children: [
              Expanded(
                  flex: 9,
                  child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: '오늘의 한마디를 입력하세요',
                        contentPadding: const EdgeInsets.only(
                            left: 20.0, bottom: 10, top: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      controller: _controller,
                    onFieldSubmitted: (_controller) {
                      StorageService().getLoginId().then(
                            (token) {
                              print("${this._controller.text} 야 이거 됨" );
                          CommentService().createComment(
                              new CommentCommonDTO(
                                comment: this._controller.text,
                                ddayId: widget.dDayId,
                                token: token,
                              )
                          );
                          this._controller.text = "";
                        },
                      );
                      Provider.of<CommentInfiniteProvider>(context, listen: false).init();
                      Future.microtask(() {
                        Provider.of<CommentInfiniteProvider>(context, listen: false).fetchItems(ddayId: widget.dDayId);
                      });
                      FocusScope.of(context).unfocus();
                    },
                  )
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Image.asset(
                    "assets/icons/iconReturn.png",
                    width: 22,
                    height: 22,
                  ),
                  onPressed: () {
                    print("댓글 : ${_controller.text}");
                    print("게시글 번호 : ${widget.dDayId}");
                    StorageService().getLoginId().then(
                          (token) {
                         CommentService().createComment(
                            new CommentCommonDTO(
                              comment: this._controller.text,
                              ddayId: widget.dDayId,
                              token: token,
                            ),
                        );
                         this._controller.text = "";
                      },
                    );
                    Provider.of<CommentInfiniteProvider>(context, listen: false).init();
                    Future.microtask(() {
                      Provider.of<CommentInfiniteProvider>(context, listen: false).fetchItems(ddayId: widget.dDayId);
                    });
                    FocusScope.of(context).unfocus();
                  },
                ),
              )
            ],
          ),
        )
            :  RawKeyboardListener(
            focusNode: FocusNode(),
            onKey: (event) {
            },
            child:  Row(
              children: [
                Expanded(
                    flex: 9,
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: '오늘의 한마디를 입력하세요',
                        contentPadding: const EdgeInsets.only(
                            left: 20.0, bottom: 10, top: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    )),
              ],
            )
        ));
  }

  currentlyUnfollow() {
    return RaisedButton(
      onPressed: () {},
      color: Colors.black,
      textColor: Colors.white,
      child: Text(
        '디데이 구독하기',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
