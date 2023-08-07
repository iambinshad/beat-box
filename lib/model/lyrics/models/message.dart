import 'package:beatabox/model/lyrics/models/body.dart';
import 'package:beatabox/model/lyrics/models/header.dart';
import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';
@JsonSerializable()
class Message {
  Header? header;
  Body? body;

  Message({this.header, this.body});

  factory Message.fromJson(Map<String, dynamic> json) {
    return _$MessageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
