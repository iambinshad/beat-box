import 'package:json_annotation/json_annotation.dart';

part 'lyrics.g.dart';

@JsonSerializable()
class Lyrics {
  @JsonKey(name: 'lyrics_body')
  String? lyricsBody;
  @JsonKey(name: 'lyrics_language')
  String? lyricsLanguage;

  Lyrics({
    this.lyricsBody,
    this.lyricsLanguage,
  });

  factory Lyrics.fromJson(Map<String, dynamic> json) {
    return _$LyricsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LyricsToJson(this);
}
