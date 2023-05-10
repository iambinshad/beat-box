import 'dart:convert';
import 'dart:developer';
import 'package:beatabox/core/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:beatabox/model/lyrics/lyrics_model.dart';

class FetchLyrics {
  
  Future<LyricsModel?> getLyrics(
      {required String title, required String artist}) async {
    String apikey = ApiConfigration.apiKey;
    final response = await http.get(Uri.parse(
        "http://api.musixmatch.com/ws/1.1/matcher.lyrics.get?q_track=$title&q_artist=$artist&apikey=$apikey"));
    if (response.statusCode == 200) {
      log(response.body.toString());
      var data = json.decode(response.body) as Map<String, dynamic>;
      final result = LyricsModel.fromJson(data);
      return result;
    }
    return null;
    
  }
}