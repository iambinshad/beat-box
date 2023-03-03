import 'package:flutter/cupertino.dart';

import '../../controller/get_all_song_controller.dart';

class NowProvider extends ChangeNotifier {
  bool isShuffling = false;
  bool firstsong = false;  
  int large = 0;
  bool lastSong = false;
   Duration duration = const Duration();
  Duration position = const Duration();

  void ChangeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    GetAllSongController.audioPlayer.seek(duration);
    notifyListeners();
  }

  void playSong() {
    GetAllSongController.audioPlayer.play();
    GetAllSongController.audioPlayer.durationStream.listen((d) {
      
        duration = d!;
      
    });
    GetAllSongController.audioPlayer.positionStream.listen((p) {
      
        position = p;
      
    });
  }
}
