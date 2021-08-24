import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar_client/service/storage_service.dart';

class WithdrawButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: FlatButton(
              padding: EdgeInsets.all(0),
              color: Colors.transparent,
              splashColor: Colors.black26,
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            topLeft: Radius.circular(30.0))),
                    context: context,
                    builder: (builder) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250.0,
                        padding: EdgeInsets.only(top: 50,left: 15,right: 15,bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("데이데이 회원 탈퇴를 하시겠어요?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            SizedBox(height: 10.0),
                            Text("탈퇴하시면 계정은 바로 삭제되며",style: TextStyle(color: Colors.grey)),
                            Text("다시 복구할 수 없어요.",style: TextStyle(color: Colors.grey)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 5,right: 5,top: 40),
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
                                              style: BorderStyle.solid
                                            )
                                          ),
                                        )
                                    )
                                ),
                                Expanded(
                                    flex: 6,
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 5,right: 5,top: 40),
                                        child: ButtonTheme(
                                          height: 50,
                                          child: RaisedButton(
                                            color: Color.fromRGBO(235, 82, 82, 1.0),
                                            child: Text("탈퇴할래요",style: TextStyle(color: Colors.white)),
                                            onPressed: ()  {
                                            StorageService().withdraw();
                                              Get.offAllNamed("/login");
                                            },
                                          ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                            )
                                        )
                                    )
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    });
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text("회원 탈퇴",
                        style: TextStyle(fontSize: 12,color: Colors.grey)),
                    flex: 20,
                  ),
                ],
              )
          ),
        )
      ],
    );
  }
}