import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar_client/service/storage_service.dart';

class LogoutButton extends StatelessWidget {

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
                        height: 240.0,
                        padding: EdgeInsets.only(top: 50,left: 15,right: 15,bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("로그아웃 하시겠어요?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            SizedBox(height: 10.0),
                            Text("다시 로그인해야 이용할 수 있습니다.",style: TextStyle(color: Colors.grey)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5,right: 5,top: 50),
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
                                        )
                                    ),

                                  )
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5,right: 5,top: 50),
                                    child: ButtonTheme(
                                      height: 50,
                                      child: RaisedButton(
                                        color: Color.fromRGBO(34, 34, 34, 1.0),
                                        child: Text("로그아웃",style: TextStyle(color: Colors.white)),
                                        onPressed: ()  {
                                         StorageService().logout();
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
                    child: Text("로그아웃",
                        style: TextStyle(fontSize: 15)),
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