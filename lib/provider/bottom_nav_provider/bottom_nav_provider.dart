import 'package:flutter/cupertino.dart';

class BottomNavProv extends ChangeNotifier {
  int currentSelectedIndex = 0;

  void bottomSwitching(index) {
    currentSelectedIndex = index;
    notifyListeners();
  }
  void reload(){
    notifyListeners();
  }
}
