import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sugar_client/view/create/createDDay.dart';

class CreateTitleField extends StatefulWidget {
  final TextEditingController _controller;
  CreateTitleField(this._controller);
  _CreateTitleFieldState createState() => _CreateTitleFieldState();

}

class _CreateTitleFieldState extends State<CreateTitleField> {

  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 300,
          child: TextFormField(
            controller: widget._controller,
            focusNode: focusNode,
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10, right: 10),
                hintText: "일정 제목을 입력하세요.",
                errorStyle: TextStyle(height: 0),
                hintStyle: TextStyle(fontSize: 24,color: Colors.black.withOpacity(0.3),)),
            validator: (title) {
              CreateDDay.checkValidation = false;
              if(title.isEmpty || title==null) {
                //스낵바
/*                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("제목을 넣어주세요"),
                  )
                );
                return "";*/
                CreateDDay.checkValidation = true;
                Fluttertoast.showToast(
                    msg: "제목을 입력해주세요",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0);
                return "";
              }
              return null;
            },
          ),
        )
      ],
    );
  }


}