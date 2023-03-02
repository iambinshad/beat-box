import 'package:flutter/cupertino.dart';

class HomePageProvider extends ChangeNotifier {
  bool isGridveiw = true;
  void viewtype() {
    isGridveiw = !isGridveiw;
    notifyListeners();
  }
}
