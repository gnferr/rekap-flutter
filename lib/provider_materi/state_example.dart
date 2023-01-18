import 'package:flutter/material.dart';

class StateColor with ChangeNotifier {
  bool _isColor = false;

  Color get getThisColor {
    return _isColor ? Colors.purpleAccent : Colors.yellowAccent;
  }

  bool get getIsColor {
    return _isColor;
  }

  set setIsColor(bool value) {
    _isColor = value;
    notifyListeners();
  }
}
