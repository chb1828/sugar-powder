
import 'package:flutter/material.dart';

class ColorItem {
  bool isSelected;
  Color color;
  ColorItem(this.color,this.isSelected);
}
class ColorTile extends StatelessWidget {
  ColorTile(this._color);
  final ColorItem _color;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0),
        child: _color.isSelected
                ? Container(
          padding: EdgeInsets.all(2.0),
          decoration: BoxDecoration(shape: BoxShape.circle, color: _color.color),
          child: Container(
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child : CircleAvatar(
                radius: 25,
                backgroundColor: _color.color,
                child: Icon(
                  Icons.check,
                  size: 25.0,
                  color: Colors.white,
                ),
              )
          ),
        ) : Container(
          padding: EdgeInsets.all(2.0),
          child: Container(
            padding: EdgeInsets.all(2.0),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: _color.color,
            ),
            decoration: BoxDecoration(
                color: Colors.white
            ),
          ),
        )
    );
  }
}

