import 'dart:developer';

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
      notifyListeners();
      // log(allData?.message?.body?.lyrics?.lyricsBody??"nothing found!",name: 'lyrics');
    });
    await Future.delayed(Duration(milliseconds: 3000));
    changeIsLoading(false);
    notifyListeners();
  }
}
