// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      header: json['header'] == null
          ? null
          : Header.fromJson(json['header'] as Map<String, dynamic>),
      body: json['body'] == null
          ? null
          : Body.fromJson(json['body'] as Map<String, dynamic>),
    );
// Message _$MessageFromJson(Map<String, dynamic> json) => Message(
//       header: json['header'] == null
//           ? null
//           : (json['header'])
//               .map((item) => Header.fromJson(item as Map<String, dynamic>))
//               .toList(),
//       body: json['body'] == null
//           ? null
//           : (json['body'])
//               .map((item) => Body.fromJson(item as Map<String, dynamic>))
//               .toList(),
//     );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'header': instance.header,
      'body': instance.body,
    };
