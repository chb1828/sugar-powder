import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar_client/service/storage_service.dart';
import 'package:sugar_client/service/user_service.dart';

class SetProfilePage extends StatefulWidget{

  _SetProfilePageState createState() => _SetProfilePageState();
}

class _SetProfilePageState extends State<SetProfilePage> {
  var editTextController = new TextEditingController();

  @override
  void initState() {
    getNickname();
  }

  void getNickname() async {
    editTextController.text = await StorageService().getNickname();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        title: Text("프로필 편집",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white60,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              UserService().updateNickname(editTextController.text);
              Navigator.pop(context,editTextController.text);
            },
          ),
        ],
      ),
      body: Container(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child:
                      Text("닉네임",style: TextStyle(fontWeight: FontWeight.bold),),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child:
                      ButtonTheme(
                        child: TextFormField(
                          //controller: widget._controller,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              errorBorder: InputBorder.none),
                          controller: editTextController,
                        ),
                      ),
                  )

                ],
              ),
            ],
          ),
        )
      ),
    );
  }


}