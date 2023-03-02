import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingProvider extends ChangeNotifier {
  int entry = 0;
  bool skipbutton = false;
  bool onLastPage = false;
  bool getStarted = false;

  void entryCounting() async {
    int entryCount = 0;
    entryCount = entryCount + 1;
    entry = entryCount;

    final sharedprefs = await SharedPreferences.getInstance();
    //save enterence
    await sharedprefs.setInt('enterCount', entry);

    notifyListeners();
  }

  void isLastPage(index) {
    onLastPage = (index == 2);
    skipbutton = (index == 2);
    getStarted = (index == 2);
    notifyListeners();
  }
}
