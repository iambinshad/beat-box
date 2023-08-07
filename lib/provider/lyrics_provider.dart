
import 'package:beatabox/controller/fetch_lyrics_service.dart';
import 'package:beatabox/model/lyrics/lyrics_model.dart';
import 'package:flutter/material.dart';

class LyricsProvider with ChangeNotifier {
  LyricsModel? allData;
  bool isLoading = false;
  void changeIsLoading(value)async {
    isLoading = value;
    notifyListeners();

  }
  Future<void> callLyricsApiService(String artist, String title) async {
    changeIsLoading(true);
    notifyListeners();
    FetchLyrics().getLyrics(artist: artist, title: title).then((value) {
      allData = value;
      if(allData == null){
        allData = null;
        notifyListeners();
      }
      notifyListeners();
    });
    await Future.delayed(const Duration(milliseconds: 3000));
    changeIsLoading(false);
    notifyListeners();
  }
}
