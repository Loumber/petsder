// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PetResponseImpl _$$PetResponseImplFromJson(Map<String, dynamic> json) =>
    _$PetResponseImpl(
      id: json['id'] as String,
      age: json['age'] as String,
      breed: json['breed'] as String,
      description: json['description'] as String,
      gender: json['gender'] as String,
      name: json['name'] as String,
      photos:
          (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$$PetResponseImplToJson(_$PetResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'age': instance.age,
      'breed': instance.breed,
      'description': instance.description,
      'gender': instance.gender,
      'name': instance.name,
      'photos': instance.photos,
      'type': instance.type,
    };
