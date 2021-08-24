import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sugar_client/dto/dday/dday_dto.dart';
import 'package:sugar_client/service/dday_service.dart';
import 'package:sugar_client/service/storage_service.dart';
import 'package:sugar_client/util/converter.dart';
import 'package:sugar_client/view/create/colorProvider.dart';
import 'package:sugar_client/view/create/widget/colorSelectSlide.dart';
import 'package:sugar_client/view/create/widget/createFormFields.dart';
import 'package:sugar_client/view/create/widget/createTitleField.dart';

import 'package:sugar_client/view/create/widget/emojiProfile.dart';
import 'package:sugar_client/view/create/widget/setDDayType.dart';


enum ProfileMarker { NONE, EMOJI }


class CreateDDay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateDDayState();

  static bool checkValidation = false;
  final dday;

  CreateDDay(this.dday);
}

class _CreateDDayState extends State<CreateDDay> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _emojiController = TextEditingController();

  List<String> _tags = new List();
  DType _dType = DType.PUBLIC;

  Color updateColor;
  String dType;
  bool validCheck = false;

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  Future<DDayDTO> _futureDDay;


  @override
  void initState() {

    //밸리드 체인지 리스너 장착
    _titleController.addListener(onValidChange);
    _dateController.addListener(onValidChange);
    //dday가 비어있지 않으면 업데이트 화면
    if(widget.dday!=null) {
      _emojiController.text=widget.dday.emoji;
      _titleController.text=widget.dday.title;
      Map<String,String> dateMap = Converter().convertToText(widget.dday.date);
      _dateController.text=dateMap["date"];
      _timeController.text=dateMap["time"];
      _placeController.text=widget.dday.place;
      _descriptionController.text=widget.dday.description;
      updateColor = Converter().colorFromHex(widget.dday.color);
      widget.dday.ddayType=="PRIVATE" ? _dType = DType.PRIVATE : _dType = DType.PUBLIC;
      _tags = widget.dday.tags;
    }
  }

  // 필수 값들이 전부다 들어갔으면 버튼 색상을 변경해주기 위한 리스너
  void onValidChange(){
    if(_titleController.text.isNotEmpty && _dateController.text.isNotEmpty) {
      setState(() {
        validCheck = true;
      });
    }else{
      setState(() {
        validCheck = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.dday==null ?
      Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "디데이 만들기",
              style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      if(_key.currentState.validate()) {
                        StorageService().getLoginId().then((token) {
                          _futureDDay = DDayPostService().createDDay(new DDayDTO(
                              title: _titleController.text,
                              place: _placeController.text,
                              description: _descriptionController.text,
                              color: Provider.of<ColorProvider>(context,listen: false).getColor().value.toRadixString(16).toString(),
                              tags: _tags,
                              date: _dateController.text,
                              time: _timeController.text,
                              emoji: _emojiController.text,
                              ddayType: _dType.toString().split('.').last,
                              token: token
                          ));

                          if(_futureDDay != null) {
                            _futureDDay.then((value) {
                              _dType = DType.PUBLIC;              // 다시 _dType를 PUBLIC 으로 변경
                              Get.back(result: value.id);         // 디테일 페이지 이동을 위한 id 값
                            }).catchError((error) {
                              print(error);
                              Fluttertoast.showToast(
                                  msg: "실패했습니다",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.lightBlue,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });
                          }
                        });
                      }
                    });
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: validCheck ? Text("완료",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        )) : Text("완료",
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        )),
                  )
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  ImageProfile(_emojiController),
                  SizedBox(height: 20),
                  CreateTitleField(_titleController),
                  SizedBox(
                    height: 20,
                  ),
                  CreateFormFields(_placeController,_descriptionController,_tags,_dateController,_timeController),
                  SizedBox(height: 20),
                  ColorSelectSlide(updateColor),
                  SizedBox(height: 20),
                  SetDDayType(
                    changedDType: (value) {
                      _dType = value;
                    },
                    selectDType: _dType,
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            )
          ),
        ),
    ) :
    Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "디데이 수정하기",
              style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      if(_key.currentState.validate()) {
                        StorageService().getLoginId().then((token) {
                          _futureDDay = DDayPostService().updateDDay(new DDayDTO(
                              id: widget.dday.id,
                              title: _titleController.text,
                              place: _placeController.text,
                              description: _descriptionController.text,
                              color: Provider.of<ColorProvider>(context,listen: false).getColor().value.toRadixString(16).toString(),
                              tags: _tags,
                              date: _dateController.text,
                              time: _timeController.text,
                              emoji: _emojiController.text,
                              ddayType: _dType.toString().split('.').last,
                              token: token
                          ));
                          if(_futureDDay != null) {
                            _futureDDay.then((value) {
                              _dType = DType.PUBLIC;
                              Get.back(result: value.id);
                            }).catchError((error) {
                              Fluttertoast.showToast(
                                  msg: "실패했습니다",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.lightBlue,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });
                          }
                        });
                      }
                    });
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("완료",
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 20,
                        )),
                  )
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  ImageProfile(_emojiController),
                  SizedBox(height: 20),
                  CreateTitleField(_titleController),
                  SizedBox(
                    height: 20,
                  ),
                  CreateFormFields(_placeController,_descriptionController,_tags,_dateController,_timeController),
                  SizedBox(height: 20),
                  ColorSelectSlide(updateColor),
                  SizedBox(height: 20),
                  SetDDayType(
                    changedDType: (value) {
                      _dType = value;
                    },
                    selectDType: _dType,
                  )
                ],
              ),
            )
        ),
      ),
    );
  }

}
