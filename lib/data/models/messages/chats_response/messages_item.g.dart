// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatsResponseImpl _$$ChatsResponseImplFromJson(Map<String, dynamic> json) =>
    _$ChatsResponseImpl(
      withPetId: json['withPetId'] as String,
      chatId: json['chatId'] as String,
      lastMessage: json['lastMessage'] as String?,
      lastMessageTime:
          const TimestampConverter().fromJson(json['lastMessageTime']),
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$ChatsResponseImplToJson(_$ChatsResponseImpl instance) =>
    <String, dynamic>{
      'withPetId': instance.withPetId,
      'chatId': instance.chatId,
      'lastMessage': instance.lastMessage,
      'lastMessageTime':
          const TimestampConverter().toJson(instance.lastMessageTime),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
