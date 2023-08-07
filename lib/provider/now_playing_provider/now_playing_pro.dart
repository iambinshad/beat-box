import 'package:flutter/cupertino.dart';

import '../../controller/get_all_song_controller.dart';

class NowProvider extends ChangeNotifier {
  bool isShuffling = false;
    Duration duration = const Duration();
  Duration position = const Duration();

  void setDuration(value){
    duration = value;
    notifyListeners();
  }
  void setPostion(value){
    position =value;
    notifyListeners();
  }
    void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
   
    GetAllSongController.audioPlayer.seek(duration);
  }

  

}
