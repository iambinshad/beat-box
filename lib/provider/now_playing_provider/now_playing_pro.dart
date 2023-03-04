import 'package:flutter/cupertino.dart';

import '../../controller/get_all_song_controller.dart';

class NowProvider extends ChangeNotifier {
  bool isShuffling = false;

  
    void ChangeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
   
    GetAllSongController.audioPlayer.seek(duration);
  }

  

}
