import 'package:beatabox/model/lyrics/models/lyrics.dart';
import 'package:json_annotation/json_annotation.dart';
part 'body.g.dart';
@JsonSerializable()
class Body {
  Lyrics? lyrics;

  Body({this.lyrics});

  factory Body.fromJson(Map<String, dynamic> json) => _$BodyFromJson(json);

  Map<String, dynamic> toJson() => _$BodyToJson(this);
}