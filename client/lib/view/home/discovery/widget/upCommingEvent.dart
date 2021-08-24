import 'package:flutter/material.dart';
import 'package:sugar_client/view/home/today/widget/topSlider.dart';

class UpCommingEvent extends StatefulWidget {
  @override
  _UpCommingEventState createState() => _UpCommingEventState();
}

class _UpCommingEventState extends State<UpCommingEvent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "점점 다가오는",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          TopSlider("discoveryScreen"),
        ],
      ),
    );
  }
}
