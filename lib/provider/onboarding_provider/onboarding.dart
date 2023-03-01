import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingProvider extends ChangeNotifier {
  int entry = 0;

  
  void entryCounting()async {
    int entryCount = 0;
    entryCount = entryCount + 1;
    entry = entryCount;

     final sharedprefs = await SharedPreferences.getInstance();
    //save enterence
    await sharedprefs.setInt('enterCount', entry);

    notifyListeners();
  }
}
