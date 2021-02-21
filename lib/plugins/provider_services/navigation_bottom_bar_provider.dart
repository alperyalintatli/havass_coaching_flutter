import 'package:flutter/material.dart';

class NavBottombarProvider with ChangeNotifier {
  int _index;

  int get index => _index;

  set index(int value) {
    if (value != null) {
      _index = value;
    }
  }

  NavBottombarProvider(this._index);

  void setIndex(int selectedIndex) {
    _index = selectedIndex;
    notifyListeners();
  }
}
