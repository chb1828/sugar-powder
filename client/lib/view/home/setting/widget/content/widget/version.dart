import 'package:flutter/material.dart';

class Version extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Text("버전 정보",
                    style: TextStyle(fontSize: 15)),
                flex: 8,
              ),
              Expanded(
                flex: 1,
                child: Text("1.0.0",style: TextStyle(color: Colors.grey,fontSize: 15))
              )
            ],
          )
        )
      ],
    );
  }
}