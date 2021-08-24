import 'package:flutter/material.dart';
import 'package:sugar_client/constant/constant.dart';

class TextBox extends StatelessWidget {
  String textContent;
  TextStyle textStyle;

  TextBox(this.textContent, this.textStyle);
  
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          child: Text(
            textContent,
            overflow: TextOverflow.ellipsis,
            textScaleFactor: 2,
            style: textStyle,
          ),
        ),
      );
  }
}