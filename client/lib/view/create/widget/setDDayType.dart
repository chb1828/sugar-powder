import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DType { PUBLIC, PRIVATE }


class SetDDayType extends StatefulWidget {

  final ValueChanged<DType> changedDType;
  final DType selectDType;

  SetDDayType({Key key,this.changedDType,this.selectDType});
  @override
  _SetDDayTypeState createState() => _SetDDayTypeState();

}

class _SetDDayTypeState extends State<SetDDayType> {

  DType _dType;
  DType _isSwitchedDType;
  //비효율적...? 변경 할수 있으면 변경
  String _dTypeTitleText = "모두의 디데이";
  String _dTypeSubText1 = "누구나 해당 디데이에 참여할 수 있고,";
  String _dTypeSubText2 = "함께 소통할 수도 있어요.";


  @override
  void initState() {
    if(widget.selectDType==DType.PUBLIC) {
        _dType = DType.PUBLIC;
        _isSwitchedDType = DType.PUBLIC; // 스위치
    }else {
      _dType = DType.PRIVATE;
      _isSwitchedDType = DType.PRIVATE;
      _dTypeTitleText = "나의 디데이";
      _dTypeSubText1 = "전체 피드에 등록하지 않고, 나만 볼 수 있어요.";
      _dTypeSubText2 = "주변 친구들을 초대할 수 있습니다.";
    }
  }

  changeDDayType(_dType) {
    if (_dType == DType.PUBLIC) {
      setState(() {
        this._dType=_dType;
        _dTypeTitleText = "모두의 디데이";
        _dTypeSubText1 = "누구나 해당 디데이에 참여할 수 있고,";
        _dTypeSubText2 = "함께 소통할 수도 있어요.";
      });
    } else {
      setState(() {
        this._dType=_dType;
        _dTypeTitleText = "나의 디데이";
        _dTypeSubText1 = "전체 피드에 등록하지 않고, 나만 볼 수 있어요.";
        _dTypeSubText2 = "주변 친구들을 초대할 수 있습니다.";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$_dTypeTitleText",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  FlatButton(
                    color: Colors.transparent,
                    splashColor: Colors.black26,
                    onPressed: () {
                      _isSwitchedDType =_dType;
                      showModalBottomSheet(
                          context: context,
                          builder: ((builder) => ddayTypeBottomSheet()));
                    },
                    child: Text(
                      "변경",
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$_dTypeSubText1"),
                  Text("$_dTypeSubText2"),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget ddayTypeBottomSheet() {
    return StatefulBuilder(
      builder: (BuildContext context, setState) => Container(
        child: Wrap(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10, left: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '디데이 타입 설정',
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        flex: 4,
                      ),
                      Expanded(
                        child: FlatButton(
                          color: Colors.transparent,
                          splashColor: Colors.black26,
                          onPressed: () {
                            this._dType = _isSwitchedDType;
                            widget.changedDType(this._dType);
                            changeDDayType(this._dType);
                            Get.back();
                          },
                          child: Text(
                            "확인",
                            style: TextStyle(color: Colors.blue, fontSize: 17),
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
                _lineSection,
                Padding(
                  padding:
                  EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "모두의 디데이",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text("누구나 해당 디데이에 참여할 수 있고,"),
                            Text("함께 소통할 수도 있어요."),
                          ],
                        ),
                        flex: 4,
                      ),
                      Expanded(
                        child: Radio(
                          value: DType.PUBLIC,
                          groupValue: _isSwitchedDType,
                          onChanged: (value) => {
                            setState(() {
                              _isSwitchedDType=DType.PUBLIC;
                            })
                          },
                        ),
                        flex: 1,
                      )
                    ],
                  ),
                ),
                _lineSection,
                Padding(
                  padding:
                  EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("나의 디데이",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17)),
                            SizedBox(
                              height: 5,
                            ),
                            Text("전체 피드에 등록하지 않고, 나만 볼 수 있어요."),
                            Text("주변 친구들을 초대할 수 있습니다."),
                          ],
                        ),
                        flex: 4,
                      ),
                      Expanded(
                        child: Radio(
                          value: DType.PRIVATE,
                          groupValue:_isSwitchedDType,
                          onChanged: (value) {
                            setState(() {
                              _isSwitchedDType=DType.PRIVATE;
                            });
                          },
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0,)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _lineSection = Container(
    margin: EdgeInsets.only(top: 5.0),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12))),
  );

}