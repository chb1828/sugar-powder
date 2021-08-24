import 'package:flutter/material.dart';

class Paragraph extends StatelessWidget {
  Paragraph(this.items);

  final List<ParagraphItem> items;

  @override
  Widget build(BuildContext context) {
    var elements = <Widget>[];
    for (var item in items) {
      elements.add(item);
      //elements.add(SizedBox(height: 10.0));
    }
    return Column(children: elements);
  }
}

class ParagraphItem extends StatelessWidget {
  final String text;
  final Icon icon;
  final double space;
  final double fontSize;

  const ParagraphItem(
      {Key key,
      @required this.text,
      @required this.icon,
        this.fontSize = 10.0,
      this.space = 5.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: fontSize/2,right: space),
          child: icon
        ),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      ],
    );
  }
}
