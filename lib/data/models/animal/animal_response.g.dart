// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnimalResponseImpl _$$AnimalResponseImplFromJson(Map<String, dynamic> json) =>
    _$AnimalResponseImpl(
      type: json['type'] as String,
      breed: (json['breed'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$AnimalResponseImplToJson(
        _$AnimalResponseImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'breed': instance.breed,
    };
