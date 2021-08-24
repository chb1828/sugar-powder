import 'package:flutter/cupertino.dart';

class ColorProvider extends ChangeNotifier {

  Color _color;

  Color getColor() => _color;

  void setColor(Color color) {
    this._color = color;
    notifyListeners();
  }
}