import 'package:flutter/material.dart';

class BottomController extends ChangeNotifier {
  int selection = 0;
  void updateIndex(int index) {
    selection = index;
    print("current index = $selection");
    notifyListeners();
  }
}
