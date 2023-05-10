import 'dart:developer';

import 'package:beatabox/controller/fetch_lyrics_service.dart';
import 'package:beatabox/model/lyrics/lyrics_model.dart';
import 'package:flutter/material.dart';

class LyricsProvider with ChangeNotifier{
 LyricsModel? allData ;
  Future<void>callLyricsApiService(String artist, String title)async{
    await FetchLyrics().getLyrics(artist: artist,title: title).then((value){
      allData=value;
      log(allData?.message?.body?.lyrics?.lyricsBody??"nothing found!",name: 'lyrics');
     });
  }
}