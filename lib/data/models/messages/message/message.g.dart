// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageResponseImpl _$$MessageResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageResponseImpl(
      id: json['id'] as String,
      fromPetId: json['fromPetId'] as String,
      toPetId: json['toPetId'] as String,
      text: json['text'] as String,
      timestamp: const TimestampConverter().fromJson(json['timestamp']),
    );

Map<String, dynamic> _$$MessageResponseImplToJson(
        _$MessageResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromPetId': instance.fromPetId,
      'toPetId': instance.toPetId,
      'text': instance.text,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
    };
